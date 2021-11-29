class OrdersController < ApplicationController
  before_action :ensure_user_logged_in

  def new
    if current_user.role == "owner"
      session[:date_from] = params[:date_from]
      session[:date_to] = params[:date_to]
      session[:customer] = params[:customer]
      render "report"
    else
      redirect_to users_path
    end
  end

  def index
    if current_user
      if current_user.role == "customer"
        render "index"
      else
        if current_user.role == "owner"
          render "report"
        else
          render "order_clerk"
        end
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end

  def create
    if current_user
      #id = params[:id]
      cart = Cart.of_user(current_user.id)
      cart_items = CartItem.of_cart_id(cart.id)
      if !cart_items.empty?
        if current_user.role == "clerk"
          user = User.find_by(name: "Walk-in customer")
          if user
            user_id = user.id
          end
        else
          user_id = cart.user_id
        end
        order = Order.new(
          user_id: user_id,
          date: Date.today,
          delivered_at: nil,
        )
        if order.save
          session[:user_order_id] = order.id
          #cart_items = CartItem.of_cart_id(cart.id)
          if cart_items
            cart_items.each do |item|
              order_item = OrderItem.new(
                order_id: order.id,
                menu_item_id: item.menu_item_id,
                menu_item_name: item.menu_item_name,
                menu_item_price: item.menu_item.price,
                quantity: item.quantity,
              )
              if !order_item.save
                flash[:error] = order_item.errors.full_messages.join(", ")
                redirect_to users_path
              end
            end
            cart_items.each do |item|
              item.destroy
            end
          else
            flash[:error] = "No items in cart.."
            redirect_to users_path
          end
        else
          flash[:error] = order.errors.full_messages.join(", ")
          redirect_to users_path
        end
        cart.destroy
        flash[:error] = "Order placed successfully!"
        redirect_to users_path
      else
        flash[:error] = "No items in cart.."
        redirect_to "/"
      end
    else
      flash[:error] = "Unauthorized access.."
      redirect_to "/"
    end
  end
end
