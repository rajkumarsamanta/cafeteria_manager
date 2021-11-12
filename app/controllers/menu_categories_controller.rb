class MenuCategoriesController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def index
    @menu_categories = MenuCategory.all
    #@todos = current_user.todos
    render "index"
  end

  def show
    id = params[:id]
    menu_category = current_user.menu_categories.find(id)
    if menu_category
      render plain "Hey #{current_user.name} ! #{menu_category.name} is available"
    else
      flash[:error] = menu_category.errors.full_messages.join(", ")
      redirect_to menu_categories_path
    end
  end

  def create
    name = params[:name]
    new_menu = MenuCategory.new(
      name: name,
    )
    if new_menu.save
      # session[:current_user_id] = new_user.id
      # session[:current_user] = new_user.name
      # session[:current_role] = new_user.role
      redirect_to "/"
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to "/"
    end
  end

  def update
  end
end
