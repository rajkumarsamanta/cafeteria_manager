class AddMenuCategoryIdToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :menu_category_id, :integer
  end
end
