class AddAccessTokenToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :access_token, :string
  end
end
