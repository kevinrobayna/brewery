class BrewzillaTelemetry < DeviceTelemetry  
  include AttrJson::Record
  attr_json_config(default_container_attribute: :metadata)

  attr_json :temperature, :float
  attr_json :target_temperature, :float
  attr_json :connection_state, :string
  attr_json :last_reading_time_sec, :integer
end
