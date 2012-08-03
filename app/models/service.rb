require 'net/http'
class Service < ActiveRecord::Base
  attr_accessible :description, :expectation, :last_poll, :name, :poll_interval, :uri, :valid
  has_many :polls, :dependent => :destroy

  def poll_webservice

end
