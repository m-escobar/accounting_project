class AddCustomidToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :custom_id, :int
  end
end
