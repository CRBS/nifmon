class Category < ActiveRecord::Base
  attr_accessible :description, :name, :valid
  has_many :services
end
