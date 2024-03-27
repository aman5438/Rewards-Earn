class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.references :inviter, foreign_key: { to_table: :users }
      t.string :invitee_email,    limit: 100
      t.string :status,           limit: 20,   default: 'pending'

      t.timestamps
    end
  end
end
