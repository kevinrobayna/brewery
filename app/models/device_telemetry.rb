# == Schema Information
#
# Table name: device_telemetries
#
#  id                                                         :text             not null, primary key
#  mac_address(MAC address of the device)                     :text             not null
#  metadata(Holds specific information from the devices)      :jsonb            not null
#  row_key(Unique key for the telemetry data from ratp.io)    :text             not null
#  type(Used for STI, this will be Brezilla, Hydrometer, etc) :text             not null
#  version(Version of the device)                             :text             not null
#  created_at                                                 :datetime         not null
#  updated_at                                                 :datetime         not null
#  device_id                                                  :text             not null, indexed
#
# Indexes
#
#  index_device_telemetries_on_device_id  (device_id)
#
# Foreign Keys
#
#  fk_rails_3e8ec8312d  (device_id => devices.id)
#
class DeviceTelemetry < ApplicationRecord
  ulid :telemetry

  belongs_to :device
end
