class Poll < ActiveRecord::Base
  attr_accessible :response_text, :response_time, :healthy
  attr_accessor :response
  belongs_to :service
end
