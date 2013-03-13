class AddDecisionJobIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :decision_job_id, :integer
  end
end
