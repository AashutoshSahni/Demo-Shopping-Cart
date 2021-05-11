class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.float :order_amount
      t.float :shipping_charges
      t.float :total_amount_paid
      t.string :order_date
      t.string :expected_delivery_date

      t.timestamps
    end
  end
end
