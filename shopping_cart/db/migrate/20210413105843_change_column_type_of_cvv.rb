class ChangeColumnTypeOfCvv < ActiveRecord::Migration[6.1]
  def change
    remove_column :cards, :cvv, :integer
    add_column :cards, :cvv, :string
  end
end
