class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  def self.exist?(order_id)
    answer = all.where(order_id: order_id)
    if answer.empty?
      false
    else
      true
    end
  end

  def selected?(selected_id)
    id == selected_id
  end

  def self.of_order(id)
    all.where(order_id: id)
  end
end
