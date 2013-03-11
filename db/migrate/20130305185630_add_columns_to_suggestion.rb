class AddColumnsToSuggestion < ActiveRecord::Migration
  def change
    add_column :suggestions, :user_id, :integer
    add_column :suggestions, :action_id, :integer
  end
end
