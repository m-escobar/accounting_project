class ChangeAccountidToStringOnAccounts < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :account_id, :string
  end
end
