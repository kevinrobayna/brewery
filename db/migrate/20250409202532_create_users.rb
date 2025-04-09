class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users, id: :binary do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end
