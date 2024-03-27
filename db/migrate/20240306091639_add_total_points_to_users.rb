class AddTotalPointsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :total_points, :integer, default: 0
    add_column :users, :rank, :integer, default: 0
  end
end
