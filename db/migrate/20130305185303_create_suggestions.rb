class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.datetime :time
      t.string :address
      t.string :notes

      t.timestamps
    end
  end
end
