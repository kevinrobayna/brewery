# == Schema Information
#
# Table name: sessions
#
#  id         :text             not null, primary key
#  ip_address :text
#  user_agent :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :text             not null, indexed
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_758836b4f0  (user_id => users.id)
#

class Session < ApplicationRecord
  ulid :session

  belongs_to :user
end
