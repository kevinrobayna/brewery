require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Brewery
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # This disables query preparation
    config.active_record.query_log_tags_enabled = true

    # Never use ruby for db structure
    config.active_record.schema_format = :sql
    config.generators do |g|
      g.orm :active_record, primary_key_type: :text
    end

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc # Or :utc
    # config.eager_load_paths << Rails.root.join("extras")

    ActiveSupport.on_load(:active_record_postgresqladapter) do
      self.datetime_type = :timestamptz
    end

    config.active_record.strict_loading_by_default = true

    # Raise an error if doing any N+1 queries.
    config.active_record.strict_loading_mode = :n_plus_one_only
  end
end
