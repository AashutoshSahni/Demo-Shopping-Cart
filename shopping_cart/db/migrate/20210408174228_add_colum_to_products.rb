class AddColumToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :seller_name, :string
  end
end
