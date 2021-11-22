class MenuItemsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def flip_status
    @menu_categories = MenuCategory.all
    @menu_items = MenuItem.all
    id = params[:id]
    menu_item = @menu_items.find(id)
    if current_user
      if current_user.role == "owner"
        menu_item.active = !menu_item.active
        if menu_item.save
          redirect_to manage_menus_path
        else
          flash[:error] = menu_item.errors.full_messages.join(", ")
          redirect_to manage_menus_path
        end
      else
        flash[:error] = "Unauthorized access ...."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def index
    @menu_items = MenuItem.all
    session[:selected_menu_item_id] = nil
    #@todos = current_user.todos
    #render "index"
    if current_user
      if current_user.role == "owner"
        #@users = User.all
        redirect_to manage_menus_path
      else
        flash[:error] = "Unauthorized access.."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def show
    @menu_categories = MenuCategory.all
    @menu_items = MenuItem.all
    if current_user
      if current_user.role == "owner"
        id = params[:id]
        if session[:selected_menu_item_id] == id
          session[:selected_menu_item_id] = nil
        else
          # menu_category = MenuCategory.find(id)
          session[:selected_menu_item_id] = id
        end
        redirect_to manage_menus_path
        #render plain: "Hey #{current_user.name} ! #{menu_category.name} with #{session[:selected_menu_category_id]} is available"
      else
        flash[:error] = "Unauthorized access.."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def edit
    @menu_categories = MenuCategory.all
    @menu_items = MenuItem.all
    if current_user
      if current_user.role == "owner"
        session[:menu_update] = false
        session[:item_update] = true
        session[:selected_menu_item_id] = params[:id]
        render "update_item"
      else
        flash[:error] = "Unauthorized access.."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def create
    @menu_items = MenuItem.all
    @menu_categories = MenuCategory.all
    if current_user
      if current_user.role == "owner"
        item_name = params[:menu_item_name]
        item_description = params[:menu_item_description]
        item_price = params[:menu_item_price].to_i
        #menu_category_id = session[:selected_menu_category_id]
        #menu_category = MenuCategory.find_by(name: params[:menu_category_name])
        #if menu_category
        # menu_category_id = session[:selected_menu_category_id]
        #{}end
        new_menu_item = MenuItem.new(
          name: item_name,
          description: item_description,
          price: item_price,
          active: true,
          menu_category_id: session[:selected_menu_category_id],
        )
        if new_menu_item.save
          # session[:current_user_id] = new_user.id
          # session[:current_user] = new_user.name
          # session[:current_role] = new_user.role
          redirect_to menu_categories_path
        else
          flash[:error] = new_menu_item.errors.full_messages.join(", ")
          # redirect_to "/"
          redirect_to menu_categories_path
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
    update_menu_item = @menu_items.find(id)
    if current_user
      if current_user.role == "owner"
        update_menu_item.name = params[:menu_item_name]
        update_menu_item.description = params[:menu_item_description]
        update_menu_item.price = params[:menu_item_price]
        if update_menu_item.save
          redirect_to manage_menus_path
        else
          flash[:error] = update_menu_item.errors.full_messages.join(", ")
          redirect_to manage_menus_path
        end
      else
        flash[:error] = "Unauthorized access ...."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def destroy
    if current_user
      if @current_user.role == "owner"
        id = params[:id]
        menu_item = MenuItem.find(id)
        if menu_item.destroy
          flash[:error] = "Menu Item successfully deleted"
          redirect_to manage_menus_path
        else
          flash[:error] = menu_item.errors.full_messages.join(", ")
          redirect_to manage_menus_path
        end
      else
        flash[:error] = "Unauthorized access..."
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end
end
