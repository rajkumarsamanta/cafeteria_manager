class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :menu_item

  def self.of_cart_id(id)
    all.where(cart_id: id)
  end
end
