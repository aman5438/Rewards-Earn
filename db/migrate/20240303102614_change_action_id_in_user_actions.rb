class ChangeActionIdInUserActions < ActiveRecord::Migration[7.0]
  def change
    change_column :user_actions, :action_id, :bigint, null: true
  end
end
