class MenuCategoriesController < ApplicationController
  skip_before_action :ensure_user_logged_in
  @menu_items = MenuItem.all

  def new
  end

  def manage_menus
    if current_user
      if current_user.role == "owner"
        render "manage_menus"
      else
        redirect_to users_path
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def add_item
    #session[:menu_update] = false
    if current_user
      @users = User.all
      if current_user.role == "owner"
        id = params[:id]
        session[:selected_menu_category_id] = id
        render "add_item"
      else
        redirect_to users_path
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def index
    @menu_items = MenuItem.all
    @menu_categories = MenuCategory.all
    session[:selected_menu_category_id] = nil
    # session[:selected] = nil
    #@todos = current_user.todos
    #{}render "index"
    if current_user
      @users = User.all
      if current_user.role == "owner"
        render "manage_menus"
      else
        redirect_to users_path
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def show
    @menu_categories = MenuCategory.all
    id = params[:id]
    @menu_items = MenuItem.all
    session[:menu_selected] = params[:menu_selected]
    if session[:menu_selected]
      session[:menu_update] = false
      session[:item_update] = true
      session[:selected_menu_category_id] = id
    else
      session[:menu_update] = true
      session[:item_update] = false
      session[:selected_menu_category_id] = nil
    end
    if current_user
      #@users = User.all
      if current_user.role == "owner"
        render "manage_menus"
      else
        redirect_to users_path
      end
      # if @current_user.role == "owner"
      #   render "manage_menus"
    else
      redirect_to "/"
    end
  end

  def edit
    @menu_categories = MenuCategory.all

    @menu_items = MenuItem.all
    session[:selected_menu_category_id] = params[:id]
    session[:menu_update] = true
    session[:item_update] = false
    if current_user
      if current_user.role == "owner"
        render "update_menus"
      else
        redirect_to users_path
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def create
    @menu_categories = MenuCategory.all
    @menu_items = MenuItem.all
    if current_user
      if current_user.role == "owner"
        name = params[:menu_category_name]
        new_menu = MenuCategory.new(
          name: name,
          active: true,
        )
        if new_menu.save
          # session[:current_user_id] = new_user.id
          # session[:current_user] = new_user.name
          # session[:current_role] = new_user.role
          render "manage_menus"
        else
          flash[:error] = new_menu.errors.full_messages.join(", ")
          #redirect_to "/"
          render "manage_menus"
        end
      else
        flash[:error] = "Unauthorized access ...."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def update
    @menu_categories = MenuCategory.all
    @menu_items = MenuItem.all
    id = params[:id]
    update_menu_category = @menu_categories.find(id)
    if current_user
      if current_user.role == "owner"
        session[:selected_menu_category_id] = nil
        if (session[:menu_selected])
          update_menu_category.active = !update_menu_category.active
          update_menu_category.save
          session[:menu_update] = true
          session[:menu_selected] = nil
          render "manage_menus"
        else
          #if params[:menu_category_name] != ""
          update_menu_category.name = params[:menu_category_name]
          update_menu_category.active = update_menu_category.active
          if update_menu_category.save
            session[:menu_update] = true
            session[:menu_selected] = nil
            render "manage_menus"
          else
            flash[:error] = update_menu_category.errors.full_messages.join(", ")
            session[:menu_update] = true
            session[:menu_selected] = nil
            render "update_menus"
          end
          # else
          #   render "update_menus"
          # end
        end
      else
        flash[:error] = "Unauthorized access ...."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end
end