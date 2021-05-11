class CreateShippingDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_details do |t|
      t.string :name
      t.string :address 
      t.string :mobile_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
