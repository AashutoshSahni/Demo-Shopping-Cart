class AddColumnUserIdToOrderedItems < ActiveRecord::Migration[6.1]
  def change
    add_column :ordered_items, :user_id, :integer
  end
end
