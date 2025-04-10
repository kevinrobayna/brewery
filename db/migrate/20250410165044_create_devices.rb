class CreateDevices < ActiveRecord::Migration[8.1]
  def change
    create_table :devices, id: :text do |t|
      t.text :name, null: false, comment: "Device Name shown in the UI"
      t.uuid :ratp_id, null: false, comment: "Primary key from the ratp.io API"
      t.text :type, null: false, comment: "Used for STI, this will be Brezilla, Hydrometer, etc"
      t.jsonb :metadata, null: false, default: {}, comment: "Holds specific information from the devices"

      t.timestamps
    end

    add_index :devices, :name, unique: true, comment: "We don't want to have devices with the same name"
    add_index :devices, :ratp_id, unique: true, comment: "This is a PK on the ratp.io API"
    add_index :devices, :type
  end
end
