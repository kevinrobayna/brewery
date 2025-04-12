# == Schema Information
#
# Table name: brews
#
#  id         :text             not null, primary key
#  name       :text
#  state      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Brew < ApplicationRecord
end
