class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :stock_symbol
      t.datetime :date_purchased
      t.integer :amount_purchased

      t.timestamps
    end
  end
end
