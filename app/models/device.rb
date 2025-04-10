# == Schema Information
#
# Table name: devices
#
#  id                                                         :text             not null, primary key
#  metadata(Holds specific information from the devices)      :jsonb            not null
#  name(Device Name shown in the UI)                          :text             not null, indexed
#  type(Used for STI, this will be Brezilla, Hydrometer, etc) :text             not null, indexed
#  created_at                                                 :datetime         not null
#  updated_at                                                 :datetime         not null
#  ratp_id(Primary key from the ratp.io API)                  :uuid             not null, indexed
#
# Indexes
#
#  index_devices_on_name     (name) UNIQUE
#  index_devices_on_ratp_id  (ratp_id) UNIQUE
#  index_devices_on_type     (type)
#

class Device < ApplicationRecord
  ulid :device

  has_many :device_telemetries, dependent: :destroy

  normalizes :name, with: ->(e) { e.strip.capitalize }
end
