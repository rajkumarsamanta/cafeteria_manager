class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def manage_users
    if current_user && current_user.role == "owner"
      @users = User.all
      render "manage_users"
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def changepassword
    if current_user
      render "changepassword"
    else
      render "home/index"
    end
  end

  def index
    @menu_categories = MenuCategory.all
    #@users = User.all
    if current_user
      if current_user.role == "owner"
        redirect_to manage_menus_path
      else
        render "index"
      end
    else
      render "home/index"
    end
  end

  def show
    if current_user && current_user.role == "owner"
      id = params[:id]
      user = User.find(id)
      #selected = params[:selected]
      session[:selected_id] = id
      session[:selected_user] = user.name
      session[:selected_role] = user.role
      # selected_user = session[:selected_user]
      if user
        render "changepassword"
        #render plain: "Hey #{user.name} ! #{user.role} ID:#{current_user.id} is #{id}"
        #redirect_to changepassword_user_path
      else
        flash[:error] = user.errors.full_messages.join(", ")
        redirect_to manage_users_path
      end
    else
      flash[:error] = "Unauthorized access..."
      redirect_to manage_users_path
    end
  end

  def create
    if current_user
      if (current_user.role == "owner")
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
          redirect_to manage_users_path
        else
          flash[:error] = new_user.errors.full_messages.join(", ")
          redirect_to manage_users_path
        end
      else
        flash[:error] = "Unauthorized access"
        redirect_to "/"
      end
    else
      name = params[:name]
      role = "customer"
      email = params[:email]
      password = params[:password]
      new_user = User.new(
        name: name,
        role: role,
        email: email,
        password: password,
      )
      if new_user.save
        session[:current_user_id] = new_user.id
        session[:current_user] = new_user.name
        session[:current_role] = new_user.role
        redirect_to "/"
      else
        flash[:error] = new_user.errors.full_messages.join(", ")
        redirect_to new_user_path
      end
    end
  end

  def update
    if current_user
      @users = User.all
      # id = params[:id]
      # session[:selected_user] = @users.find(id)
      if current_user.role == "owner"
        user = User.find(params[:id])
        password = params[:password]
        email = params[:email]
        name = params[:name]
        role = params[:role]
        user.password = password
        user.name = name
        user.role = role
        user.email = email
      else
        user = current_user
        user.password = params[:password]
      end
      if user.save
        flash[:error] = "Update successfully"
        if current_user.role == "owner"
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
    if current_user
      id = params[:id]
      user = User.find(id)
      if current_user != user
        user.destroy
        flash[:error] = "Successfully deleted"
        redirect_to manage_users_path
      else
        flash[:error] = "You can't delete yourself .."
        redirect_to manage_users_path
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end
end
