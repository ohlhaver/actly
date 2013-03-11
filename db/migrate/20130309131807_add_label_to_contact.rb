class AddLabelToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :label, :string
  end
end
