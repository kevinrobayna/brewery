class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions, id: :binary do |t|
      t.references :user, null: false, foreign_key: true, type: :binary
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
