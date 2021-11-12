class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    @menu_categories = MenuCategory.all
    @users = User.all
    if current_user
      redirect_to users_path
    else
      render "index"
    end
  end
end
