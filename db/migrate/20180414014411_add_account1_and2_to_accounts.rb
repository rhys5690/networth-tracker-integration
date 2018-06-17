class AddAccount1And2ToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :account_1_total, :integer
    add_column :accounts, :account_2_total, :integer
  end
end
