class CartsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  @carts = Cart.all

  def new
  end

  def index
  end

  def edit
    if current_user
      id = params[:id]
      cart = Cart.of_user(current_user.id)
      if !cart
        cart = Cart.new(
          user_id: current_user.id,
          date: Date.today,
        )
        if cart.save
          session[:user_cart_id] = cart.id
        else
          flash[:error] = new_menu.errors.full_messages.join(", ")
          redirect_to users_path
        end
      end
      # render plain: "#{current_user.name}, ID: #{cart.user_id}, Cart ID: #{cart.id}"
      #menu_item = MenuItem.find(id)
      if CartItem.of_cart_id(cart.id)
        cart_item = CartItem.of_cart_id(cart.id).find_by(menu_item_id: id)
      else
        cart_item = nil
      end
      if !cart_item
        menu_item = MenuItem.find(id)
        cart_item = CartItem.new(
          cart_id: cart.id,
          menu_item_id: menu_item.id,
          menu_item_name: menu_item.name,
          menu_item_price: menu_item.price,
          quantity: 1,
        )
      else
        cart_item.quantity = cart_item.quantity + 1
      end
      if cart_item.save
        redirect_to users_path
      else
        flash[:error] = cart_item.errors.full_messages.join(", ")
        redirect_to users_path
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def destroy
  end
end
