class CreateOrderedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :ordered_items do |t|
      t.string :description
      t.float :price_per_item
      t.integer :quantity
      t.float :total_price
      t.string :file
      t.string :seller_name
      t.integer :return_or_replacement_applicable_days
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
