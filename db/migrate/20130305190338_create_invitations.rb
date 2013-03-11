class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :action_id
      t.integer :invitee_id

      t.timestamps
    end
  end
end
