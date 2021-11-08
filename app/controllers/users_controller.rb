class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def index
    if current_user
      render "index"
    else
      render "home/index"
    end
  end

  def create
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
      session[:current_user_id] = new_user.id
      session[:current_user] = new_user.name
      session[:current_role] = new_user.role
      #redirect_to users_path
      redirect_to "/"
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
