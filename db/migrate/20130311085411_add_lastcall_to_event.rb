class AddLastcallToEvent < ActiveRecord::Migration
  def change
    add_column :events, :lastcall, :datetime
  end
end
