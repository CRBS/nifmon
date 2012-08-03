class Poll < ActiveRecord::Base
  attr_accessible :response_text, :response_time
  belongs_to :service
end
