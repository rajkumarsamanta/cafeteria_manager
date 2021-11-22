class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :user

  def self.of_user(id)
    where(user_id: id).first
  end
end
