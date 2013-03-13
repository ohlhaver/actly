class AddScoreToSuggestion < ActiveRecord::Migration
  def change
    add_column :suggestions, :score, :integer
  end
end
