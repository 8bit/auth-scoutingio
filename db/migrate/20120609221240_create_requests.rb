class CreateRequests < ActiveRecord::Migration
  def change
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
