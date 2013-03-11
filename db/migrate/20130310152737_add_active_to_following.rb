class AddActiveToFollowing < ActiveRecord::Migration
  def change
    add_column :followings, :active, :boolean
  end
end
