class CreateBrews < ActiveRecord::Migration[8.1]
  def change
    create_table :brews, id: :text do |t|
      t.text :name, null: false, comment: "Name of the beer"
      t.text :state, null: false, comment: "State of the brew process, scheduled, brewing, ageing, etc"
      t.jsonb :metadata, default: {}, comment: "Holds specific information from the brewing process"

      t.timestamps
    end
  end
end
