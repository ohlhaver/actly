class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :followings, :action_id, :event_id
  	rename_column :invitations, :action_id, :event_id
  	rename_column :suggestions, :action_id, :event_id
  end

end
