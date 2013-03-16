class AddAuthTokenToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :auth_token, :string
  end
end
