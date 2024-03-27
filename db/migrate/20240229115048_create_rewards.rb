class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.references :user, foreign_key: true
      t.integer    :points
      t.string     :source_type, limit: 40
      t.integer    :source_id
      t.timestamps
    end
    add_index :rewards, [:source_type, :source_id], name: :reward_source
  end
end
