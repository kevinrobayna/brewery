class ApplicationRecord < ActiveRecord::Base
  include Ulid

  primary_abstract_class
end
