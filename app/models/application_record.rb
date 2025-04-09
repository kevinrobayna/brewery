class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include ULID::Rails
  ulid :id, auto_generate: true # The first argument is the ULID column name
end
