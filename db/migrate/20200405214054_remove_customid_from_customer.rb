class RemoveCustomidFromCustomer < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :custom_id, :int
  end
end
