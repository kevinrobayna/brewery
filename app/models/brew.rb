# == Schema Information
#
# Table name: brews
#
#  id                                                                :text             not null, primary key
#  metadata(Holds specific information from the brewing process)     :jsonb
#  name(Name of the beer)                                            :text             not null
#  state(State of the brew process, scheduled, brewing, ageing, etc) :text             not null
#  created_at                                                        :datetime         not null
#  updated_at                                                        :datetime         not null
#
class Brew < ApplicationRecord
end
