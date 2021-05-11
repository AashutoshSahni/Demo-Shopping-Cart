class ChangeColumnNameOfMaxQuantity < ActiveRecord::Migration[6.1]
  def change
    remove_column :cart_items, :max_quantity, :integer
    add_column :cart_items, :available_quantity, :integer
  end
end
