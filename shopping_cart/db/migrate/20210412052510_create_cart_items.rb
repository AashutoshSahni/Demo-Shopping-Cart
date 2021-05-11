class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.string :description
      t.float :price
      t.integer :quantity
      t.integer :max_quantity
      t.string :file
      t.integer :return_or_replacement_applicable_days
      t.string :seller_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
