class AddBlockedToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :blocked, :boolean
  end
end
