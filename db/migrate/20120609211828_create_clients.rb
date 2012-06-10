class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :api_token
      t.string :api_secret
      t.string :callback_url
      t.string :return_url

      t.timestamps
    end
  end
end
