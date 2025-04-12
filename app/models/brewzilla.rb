class Brewzilla < Device 
  include AttrJson::Record
  attr_json_config(default_container_attribute: :metadata)
end
