class AddColumnsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :pin_code, :string
    add_column :orders, :mobile_number, :string
    add_column :orders, :card_number, :string
  end
end
