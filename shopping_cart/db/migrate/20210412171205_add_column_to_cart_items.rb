class AddColumnToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :product_id, :integer
  end
end
