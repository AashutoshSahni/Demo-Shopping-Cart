class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :description
      t.float :price
      t.integer :return_or_replacement_applicable_days
      t.integer :quantity
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
