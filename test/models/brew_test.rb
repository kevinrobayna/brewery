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
require "test_helper"

class BrewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
