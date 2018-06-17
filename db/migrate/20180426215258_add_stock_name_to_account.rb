class AddStockNameToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :stock_name, :string
    add_column :accounts, :date_purchased, :string
  end
end
