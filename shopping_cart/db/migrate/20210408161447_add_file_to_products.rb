class AddFileToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :file, :string
  end
end
