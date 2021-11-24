class OrderItemsController < ApplicationController
  before_action :ensure_user_logged_in

  def show
    id = params[:id]
    session[:order_selected] = id
    session[:order_update] = !session[:order_update]
    if session[:order_update]
      #   session[:order_update] = !session[:order_update]
      #   # session[:item_update] = true
      session[:selected_order_id] = id
    else
      #   session[:order_update] = true
      #   # session[:item_update] = false
      session[:selected_order_id] = nil
    end
    if current_user
      #@users = User.all
      if current_user.role == "owner"
        render "orders/report"
      else
        redirect_to orders_path
      end
      # if @current_user.role == "owner"
      #   render "manage_menus"
    else
      redirect_to "/"
    end
  end

  def edit
    if current_user
      id = params[:id]
      if current_user.role == "owner"
        order = Order.find(id)
        if order
          if order.delivered_at
            order.delivered_at = nil
          else
            order.delivered_at = Date.today
          end
          order.save
        end
        render "orders/report"
      else
        if current_user.role == "clerk"
          order = Order.find(id)
          if order
            if order.delivered_at
              order.delivered_at = nil
            else
              order.delivered_at = Date.today
            end
            order.save
          end
        end
        redirect_to orders_path
      end
    else
      redirect_to "/"
    end
  end
end
