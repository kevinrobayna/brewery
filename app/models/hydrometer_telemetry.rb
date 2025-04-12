class HydrometerTelemetry < DeviceTelemetry  
  include AttrJson::Record
  attr_json_config(default_container_attribute: :metadata)

  attr_json :temperature, :float
  attr_json :gravity, :float
  attr_json :battery, :float
  attr_json :gravity_velocity, :float
  attr_json :last_reading_time_sec, :integer
end
