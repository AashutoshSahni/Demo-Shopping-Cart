class AddColumnToShippingDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :shipping_details, :pin_code, :string
    add_column :shipping_details, :city, :string
    add_column :shipping_details, :state, :string
  end
end
