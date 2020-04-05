class AddCustomidToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :custom_id, :int
  end
end
