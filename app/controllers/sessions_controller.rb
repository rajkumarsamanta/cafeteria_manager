class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      session[:current_user] = user.name
      session[:current_role] = user.role
      #redirect_to users_path
      redirect_to "/"
    else
      flash[:error] = "Invalid login credentials. Please try again.."
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    session[:current_user] = nil
    session[:current_role] = nil
    @current_user = nil
    redirect_to "/"
  end
end
