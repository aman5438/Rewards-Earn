class CreateJoinTableUsersActions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_actions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :action, null: false, foreign_key: true
      t.string :status
      t.string :meta

      t.timestamps
    end
  end
end
