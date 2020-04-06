class ChangeCustomIdToAccountIdAccount < ActiveRecord::Migration[6.0]
  def change
    rename_column :accounts, :custom_id, :account_id
  end
end
