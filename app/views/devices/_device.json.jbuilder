json.extract! device, :id, :name, :ratp_id, :connection_state, :mac_address, :type, :created_at, :updated_at
json.url device_url(device, format: :json)
