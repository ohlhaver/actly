class AddDecisionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :decision, :datetime
  end
end
