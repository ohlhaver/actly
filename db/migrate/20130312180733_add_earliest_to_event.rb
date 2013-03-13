class AddEarliestToEvent < ActiveRecord::Migration
  def change
    add_column :events, :earliest, :datetime
  end
end
