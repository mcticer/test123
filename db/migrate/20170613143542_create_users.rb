class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :real_name
      t.string :email_address
      t.string :phone_number
      t.string :password_digest
      t.boolean :active, :default => false
      t.string :remember_token
      t.string :api_key
      t.boolean :admin, :default => false

      t.timestamps
    end

    add_index :users, [:user_name, :email_address]
  end
end
