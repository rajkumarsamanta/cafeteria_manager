class MenuCategory < ApplicationRecord
  has_many :menu_items

  validates :name, presence: true
  validates :name, length: { minimum: 4 }

  def selected?(selected_id)
    id == selected_id
  end

  def self.menu_name(selected_id)
    category = MenuCategory.find_by(id: selected_id)
    if category
      category.name
    else
      "New category"
    end
  end

  def self.menu(id)
    MenuCategory.find_by(id: id)
  end

  def self.menu_id(name)
    MenuCategory.find_by(name: name).id
  end

  def self.menu(name)
    MenuCategory.find_by(name: name)
  end
end
