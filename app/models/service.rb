require 'httparty'
class Service < ActiveRecord::Base
  attr_accessible :description, :expectation, :last_poll, :name, :poll_interval, :uri, :valid, :api_format
  has_many :polls, :dependent => :destroy

  def poll_webservice
    response = HTTParty.get(@uri)
    
end
