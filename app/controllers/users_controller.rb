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

  def change_password
    if current_user && current_user.role == "owner"
      id = params[:id]
      user = User.find(id)
      session[:selected_id] = id
      session[:selected_user] = user.name
      session[:selected_role] = user.role
      session[:selected_email] = user.email
      session[:selected_password] = user.password
      if user
        session[:update_email] = nil
        session[:update_password] = true
        session[:update_user] = nil

        render "changepassword"
      else
        flash[:error] = user.errors.full_messages.join(", ")
        redirect_to manage_users_path
      end
    else
      flash[:error] = "Unauthorized access..."
      redirect_to manage_users_path
    end
  end

  def email
    if current_user && current_user.role == "owner"
      id = params[:id]
      user = User.find(id)
      session[:selected_id] = id
      session[:selected_user] = user.name
      session[:selected_role] = user.role
      session[:selected_email] = user.email
      session[:selected_password] = user.password
      if user
        session[:update_email] = true
        session[:update_password] = nil
        session[:update_user] = nil

        render "changepassword"
      else
        flash[:error] = user.errors.full_messages.join(", ")
        redirect_to manage_users_path
      end
    else
      flash[:error] = "Unauthorized access..."
      redirect_to manage_users_path
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
      session[:selected_email] = user.email

      # session[:update_email] = nil
      # session[:update_password] = nil
      # session[:update_user] = true
      if user
        session[:update_email] = nil
        session[:update_password] = nil
        session[:update_user] = true
        render "role"
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

  def edit
    if current_user
      @users = User.all
      if current_user.role == "owner"
        id = params[:id]
        user = User.find(id)
        if user #&& user.authenticate(params[:current_password])
          #         user.role = params[:role]
          #         #user.password = user.password
          #         #user.password = params[:current_password]
          #         if user.save
          #           flash[:error] = "Update successfully"
          #           session[:update_email] = nil
          #           session[:update_password] = nil
          session[:update_user] = true
          render "role"
          #           redirect_to manage_users_path
          #         else
          #           flash[:error] = user.errors.full_messages.join(", ")
          #           render "change_role"
          #         end
        else
          flash[:error] = "User not found"
          render "role"
        end
      else
        flash[:error] = "You are not authorized for this action"
        redirect_to "/"
      end
    else
      flash[:error] = "You are not loggeg in"
      redirect_to "/"
    end
  end

  def role
    if current_user && current_user.role == "owner"
      id = params[:id]
      user = User.find(id)
      session[:selected_id] = id
      session[:selected_user] = user.name
      session[:selected_role] = user.role
      session[:selected_email] = user.email
      if user
        session[:update_email] = nil
        session[:update_password] = nil
        session[:update_user] = true
        render "role"
      else
        flash[:error] = user.errors.full_messages.join(", ")
        redirect_to manage_users_path
      end
    else
      flash[:error] = "Unauthorized access..."
      redirect_to manage_users_path
    end
  end

  def update
    if current_user
      @users = User.all
      if current_user.role != "owner"
        user = current_user
        if user && user.authenticate(params[:current_password])
          user.password = params[:password]
          if user.save
            flash[:error] = "Update successfully"
            redirect_to "/"
          else
            flash[:error] = user.errors.full_messages.join(", ")
            redirect_to changepassword_user_path
          end
        else
          flash[:error] = "Invalid password"
          redirect_to changepassword_user_path
        end
      else
        id = params[:id]
        user = User.find(id)
        if user
          user.role = params[:role]
          if user.save
            flash[:error] = "Update successfully"
            redirect_to "/"
          else
            flash[:error] = user.errors.full_messages.join(", ")
            render "role"
          end
        else
          flash[:error] = "User not found"
          render "role"
        end
      end
      session[:update_email] = nil
      session[:update_password] = nil
      session[:update_user] = nil
      # if user.save
      #   flash[:error] = "Update successfully"
      #   redirect_to "/"
      # else
      #   flash[:error] = user.errors.full_messages.join(", ")
      #   if current_user.role != "owner"
      #     redirect_to changepassword_user_path
      #   else
      #     render "role"
      #   end
      # end
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
        session[:update_email] = nil
        session[:update_password] = nil
        session[:update_user] = nil
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
