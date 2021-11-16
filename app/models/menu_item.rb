class MenuItem < ApplicationRecord
  belongs_to :menu_category

  def self.of_category(selected_id)
    where("menu_category_id = ?", selected_id)
  end

  def self.exist?(selected_id)
    answer = all.where(menu_category_id: selected_id)
    if answer.empty?
      false
    else
      true
    end
  end

  def selected?(selected_id)
    id == selected_id
  end

  def self.menu_item(id)
    MenuItem.find_by(id: id)
  end

  def self.description(id)
    MenuItem.find_by(id: id).description
  end

  def self.price(id)
    MenuItem.find_by(id: id).price
  end
end
