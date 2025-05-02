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
class Hydrometer < Device
  include AttrJson::Record
  attr_json_config(default_container_attribute: :metadata)

  # # Standard ABV Formula:
  # # ABV = (OG – FG) * 131.25
  # def standard_abv
  #   og = device_telemetries.first.gravity / 1000
  #   fg = device_telemetries.last.gravity / 1000
  #
  #   (og - fg) * 131.25
  # end
  #
  # # Alternate ABV Formula:
  # # ABV = (76.08 * (OG - FG) / (1.775 - OG)) * (FG / 0.794)
  # def alternate_abv
  #   og = device_telemetries.first.gravity / 1000
  #   fg = device_telemetries.last.gravity / 1000
  #
  #   76.08 * (og - fg) / (1.775 - og) * (fg / 0.794)
  # end
end
