class CreateDeviceTelemetries < ActiveRecord::Migration[8.1]
  def change
    create_table :device_telemetries, id: :text do |t|
      t.references :device, null: false, foreign_key: true, type: :text
      t.text :row_key, null: false, comment: "Unique key for the telemetry data from ratp.io"
      t.text :type, null: false, comment: "Used for STI, this will be Brezilla, Hydrometer, etc"
      t.text :version, null: false, comment: "Version of the device"
      t.text :mac_address, null: false, comment: "MAC address of the device"
      t.datetime :reading_at, null: false, comment: "Date and time (UTC) of the readong according to the source"
      t.jsonb :metadata, null: false, default: {}, comment: "Holds specific information from the devices"

      t.timestamps
    end

    add_index :device_telemetries, :reading_at, comment: "Our graphs are all based on the reading time"
  end
end
