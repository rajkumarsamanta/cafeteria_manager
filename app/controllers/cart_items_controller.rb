class CartItemsController < ApplicationController
  before_action :ensure_user_logged_in
  @menu_items = MenuItem.all

  def plus
    if current_user
      if current_user.role != "owner"
        id = params[:id]
        cart = Cart.of_user(current_user.id)
        if CartItem.of_cart_id(cart.id)
          cart_item = CartItem.of_cart_id(cart.id).find(id)
          if cart_item
            cart_item.quantity = cart_item.quantity + 1
          end
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
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def minus
    if current_user
      if current_user.role != "owner"
        id = params[:id]
        cart = Cart.of_user(current_user.id)
        if CartItem.of_cart_id(cart.id)
          cart_item = CartItem.of_cart_id(cart.id).find(id)
          if cart_item
            if cart_item.quantity > 0
              cart_item.quantity = cart_item.quantity - 1
            end
          end
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
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def destroy
    if current_user
      if @current_user.role != "owner"
        id = params[:id]
        cart_item = CartItem.find(id)
        #render plain: "#{current_user.name}, ID: #{current_user.id}, Item ID: #{id}, Item: #{cart_item.id}"
        if cart_item.destroy
          flash[:error] = "Item removed from cart successfully"
          redirect_to users_path
        else
          flash[:error] = cart_item.errors.full_messages.join(", ")
          redirect_to users_path
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
