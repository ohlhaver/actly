class AddLabelToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :label, :string
  end
end
