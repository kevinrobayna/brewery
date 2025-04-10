class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions, id: :text do |t|
      t.references :user, null: false, foreign_key: true, type: :text
      t.text :ip_address
      t.text :user_agent

      t.timestamps
    end
  end
end
