require "ulid"
require "base32/crockford"

module Ulid
  extend ActiveSupport::Concern

  class_methods do
    def ulid(prefix, column_name: :id)
      attribute column_name, :string

      before_create do
        send(:"#{column_name}=", "#{prefix.downcase}_#{ULID.generate}") if send(column_name).nil?
      end
    end
  end
end
