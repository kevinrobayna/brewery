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

  def last_reading_time
    device_telemetries.last.reading_at
  end

  def groupped_telemetry(period: 1.month, group_by: :day)
    last_reading = (last_reading_time || Time.current).beginning_of_day
    device_telemetries
      .where("reading_at >= ?", (last_reading - period).beginning_of_day)
      .where("reading_at <= ?", last_reading.end_of_day)
      .group(
        Arel.sql("DATE_TRUNC('#{group_by}', reading_at)")
      )
      .pluck(
        Arel.sql("DATE_TRUNC('#{group_by}', reading_at)"),
        Arel.sql("array_agg(metadata)")
      ).map do |date, readings|
        is_beginning_of_day = date == date.beginning_of_day
        example = readings.first
        keys = example.keys.filter_map { it if example[it].is_a?(Numeric) }

        sums = readings.each_with_object(Hash.new(0)) do |reading, acc|
          keys.each { |key| acc[key] += reading[key] }
        end

        averages = sums.transform_values { |sum| (sum / readings.size.to_f).round(5) }
        [is_beginning_of_day ? date.to_date.to_s : date, averages]
      end
  end

  normalizes :name, with: ->(e) { e.strip.capitalize }
end
