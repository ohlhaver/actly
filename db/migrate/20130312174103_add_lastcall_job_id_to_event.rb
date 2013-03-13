class AddLastcallJobIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :lastcall_job_id, :integer
  end
end
