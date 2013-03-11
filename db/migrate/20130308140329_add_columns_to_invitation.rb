class AddColumnsToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :inviter_id, :integer
    add_column :invitations, :email, :string
  end
end
