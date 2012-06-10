class AddCodeExpiresAtToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :code_expires_at, :timestamp

  end
end
