class RemoveMenuCategoriesIdFromMenuItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :menu_items, :menu_categories_id, :integer
  end
end
