class CreateStreams < ActiveRecord::Migration[7.0]
  def change
    create_table :streams do |t|
      t.integer :count
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
