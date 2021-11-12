class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def manage_users
    if session[:current_role] == "owner"
      @users = User.all
      render "manage_users"
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def index
    @menu_categories = MenuCategory.all
    @users = User.all
    if current_user
      render "index"
    else
      render "home/index"
    end
  end

  def show
    @users = User.all
    id = params[:id]
    #selected = params[:selected]
    session[:selected_id] = id
    session[:selected_user] = @users.find(id).name
    session[:selected_role] = @users.find(id).role
    selected_user = session[:selected_user]
    if selected_user
      #render plain: "Hey #{selected_user.name} ! #{selected_user.role} ID:#{selected_user.id} is #{selected}"
      redirect_to changepassword_user_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to manage_users_path
    end
  end

  def create
    if ((session[:current_role] == "owner") || (session[:current_role] == nil))
      name = params[:name]
      role = params[:role]
      email = params[:email]
      password = params[:password]
      new_user = User.new(
        name: name,
        role: role,
        email: email,
        password: password,
      )
      if new_user.save
        if session[:current_role] != "owner"
          session[:current_user_id] = new_user.id
          session[:current_user] = new_user.name
          session[:current_role] = new_user.role
          redirect_to "/"
        else
          redirect_to manage_users_path
        end
      else
        if session[:current_role] != "owner"
          flash[:error] = new_user.errors.full_messages.join(", ")
          redirect_to new_user_path
        else
          flash[:error] = new_user.errors.full_messages.join(", ")
          redirect_to manage_users_path
        end
      end
    else
      flash[:error] = "Unauthorized access"
      redirect_to "/"
    end
  end

  def update
    if current_user
      @users = User.all
      id = params[:id]
      session[:selected_user] = @users.find(id)
      if session[:current_role] == "owner"
        user = session[:selected_user]
        password = params[:password]
        email = params[:email]
        name = params[:name]
        role = params[:role]
        user.password = password
        user.name = name
        user.role = role
        user.email = email
      else
        password = params[:password]
        user = current_user
        user.password = password
      end
      if user.save
        flash[:error] = "Update successfully"
        if session[:current_role] == "owner"
          redirect_to manage_users_path
        else
          redirect_to "/"
        end
      else
        flash[:error] = user.errors.full_messages.join(", ")
        redirect_to changepassword_user_path
      end
    else
      flash[:error] = "You are not loggeg in"
      redirect_to "/"
    end
  end

  def destroy
    id = params[:id]
    user = User.find(id)
    user.destroy
    redirect_to manage_users_path
  end
end
