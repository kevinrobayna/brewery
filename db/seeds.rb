require "rapt_api_client"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  email_address: "test@brews.com",
  password_digest: BCrypt::Password.create("password")
)

start_date = 1.week.ago.to_date
end_date = Time.zone.today.to_date

begin
  api_instance = RaptApiClient::HydrometerApi.new
  hydrometers = api_instance.api_hydrometers_get_hydrometers_get
  hydrometers.each do |hydrometer_api|
    hydrometer = Hydrometer.create!(
      name: hydrometer_api.name,
      ratp_id: hydrometer_api.id,
      created_at: hydrometer_api.created_on
    )
    opts = {hydrometer_id: hydrometer.ratp_id, start_date:, end_date:}
    api_instance.api_hydrometers_get_telemetry_get(opts).each do |telemetry|
      HydrometerTelemetry.create!(
        device_id: hydrometer.id,
        temperature: telemetry.temperature,
        gravity: telemetry.gravity,
        gravity_velocity: telemetry.gravity_velocity,
        battery: telemetry.battery,
        version: telemetry.version,
        row_key: telemetry.row_key,
        mac_address: telemetry.mac_address,
        created_at: telemetry.created_on,
        last_reading_time_sec: DateTime.now.to_i - telemetry.created_on.to_i
      )
    end
  end
rescue RaptApiClient::ApiError => e
  Rails.logger.debug { "Failed to fetch hydrometers: #{e}" }
end

begin
  api_instance = RaptApiClient::BrewZillaApi.new
  brewzillas = api_instance.api_brew_zillas_get_brew_zillas_get
  brewzillas.each do |brewzilla_api|
    brewzilla = Brewzilla.create!(
      name: brewzilla_api.name,
      ratp_id: brewzilla_api.id,
      created_at: brewzilla_api.created_on
    )
    opts = {brew_zilla_id: brewzilla.ratp_id, start_date:, end_date:}
    api_instance.api_brew_zillas_get_telemetry_get(opts).each do |telemetry|
      BrewzillaTelemetry.create!(
        device_id: brewzilla.id,
        temperature: telemetry.temperature,
        target_temperature: telemetry.target_temperature,
        connection_state: brewzilla_api.connection_state,
        last_reading_time_sec: DateTime.now.to_i - telemetry.created_on.to_i,
        version: brewzilla_api.firmware_version,
        row_key: telemetry.row_key,
        mac_address: telemetry.mac_address,
        created_at: telemetry.created_on
      )
    end
  end
rescue RaptApiClient::ApiError => e
  Rails.logger.debug { "Failed to fetch brewzillas: #{e}" }
end
