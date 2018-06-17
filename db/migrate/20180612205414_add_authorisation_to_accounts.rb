class AddAuthorisationToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :access_number, :integer
    add_column :accounts, :security_number, :integer
    add_column :accounts, :internet_password, :string
  end
end
