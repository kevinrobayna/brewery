class CreateBrews < ActiveRecord::Migration[8.1]
  def change
    create_table :brews, id: :text do |t|
      t.text :name
      t.text :state

      t.timestamps
    end
  end
end
