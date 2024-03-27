class AddUserNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, limit: 40, unique: true, index: true
  end
end
