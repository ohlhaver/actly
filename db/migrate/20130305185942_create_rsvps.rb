class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :user_id
      t.integer :suggestion_id
      t.integer :status

      t.timestamps
    end
  end
end
