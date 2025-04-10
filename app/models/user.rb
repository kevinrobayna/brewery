# == Schema Information
#
# Table name: users
#
#  id              :text             not null, primary key
#  email_address   :text             not null, indexed
#  password_digest :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#

class User < ApplicationRecord
  ulid :user

  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
