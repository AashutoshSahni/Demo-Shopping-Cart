class ChangeColumnNameOfProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :quantity, :integer
    add_column :products, :available_quantity, :integer
  end
end
