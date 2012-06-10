class Oauth2ChangesToAuthorizations < ActiveRecord::Migration
  def up
    drop_table :authorizations
    create_table :authorizations do |t|
      t.references :request
      t.references :client
      t.references :user
      t.string :authorization_code
      t.string :access_token
      t.string :refresh_token

      t.timestamps
    end
    add_index :authorizations, :request_id
    add_index :authorizations, :client_id
    add_index :authorizations, :user_id
    
  end

  def down
    drop_table :authorizations
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
