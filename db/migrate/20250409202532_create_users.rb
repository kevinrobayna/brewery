class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users, id: :text do |t|
      t.text :email_address, null: false
      t.text :password_digest, null: false

      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end
