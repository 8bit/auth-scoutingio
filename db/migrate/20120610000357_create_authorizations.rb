class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :client
      t.references :user
      t.string :authorization_token

      t.timestamps
    end
    add_index :authorizations, :client_id
    add_index :authorizations, :user_id
  end
end
