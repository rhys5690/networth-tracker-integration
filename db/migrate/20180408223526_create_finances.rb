class CreateFinances < ActiveRecord::Migration[5.1]
  def change
    create_table :finances do |t|
      t.integer :bank_account_1

      t.timestamps
    end
  end
end
