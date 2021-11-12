class MenuCategory < ApplicationRecord
  has_many :menu_items

  validates :name, presence: true
  validates :name, length: { minimum: 4 }
end
