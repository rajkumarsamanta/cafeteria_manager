class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user

  def self.of_user(user_id)
    where(user_id: user_id)
  end

  def self.of_user_name(name)
    user = User.find_by(name: name)
    if user
      where("user_id = ?", user.id)
    else
      nil
    end
  end

  def selected?(selected_id)
    id == selected_id
  end

  def self.order_count(user_id)
    orders = where(user_id: user_id)
    if orders
      orders.count
    else
      0
    end
  end

  def self.delivered(user_id)
    orders = where("user_id = ?", user_id)
    delivery_count = 0
    if orders
      orders.each do |order|
        if order.delivered_at
          delivery_count += 1
        end
      end
    end
    delivery_count
  end

  def self.pending_of_user(user_id)
    orders = where("user_id = ?", user_id)
    pending_count = 0
    if orders
      orders.each do |order|
        if !order.delivered_at
          pending_count += 1
        end
      end
    end
    pending_count
  end

  def self.pending
    orders = Order.all
    pending_count = 0
    if orders
      orders.each do |order|
        if !order.delivered_at
          pending_count += 1
        end
      end
    end
    pending_count
  end

  def delivered?
    #order = where(id: order_id)
    if delivered_at
      true
    else
      false
    end
  end

  def pending?
    #order = where(id: order_id)
    if !delivered_at
      true
    else
      false
    end
  end

  def customer
    user = User.find(user_id)
    user.name
  end

  def self.of_days(date_from, date_to)
    where("date >= ? and date <= ?", date_from, date_to)
  end

  def amount
    items = OrderItem.where(order_id: self.id)
    order_amount = 0
    if items
      items.each do |item|
        order_amount += item.menu_item_price * item.quantity
      end
    end
    order_amount
  end
end
