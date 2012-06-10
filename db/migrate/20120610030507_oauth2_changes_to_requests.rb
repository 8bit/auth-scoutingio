class Oauth2ChangesToRequests < ActiveRecord::Migration
  def up
    drop_table :requests
    create_table :requests do |t|
      t.string :response_type
      t.string :client_id
      t.string :scope
      t.string :redirect_uri
      t.string :nonce
      t.string :state
      t.text :request
      t.string :request_uri
      t.string :display
      t.string :prompt
      t.text :id_token

      t.timestamps
    end
    
  end

  def down
    drop_table :requests
    create_table :requests do |t|
      t.references :client
      t.references :user
      t.string :request_token
      t.string :access_token

      t.timestamps
    end
    add_index :requests, :client_id
    add_index :requests, :user_id
  end
end
