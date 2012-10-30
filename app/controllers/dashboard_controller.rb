class DashboardController < ApplicationController
  def edit
  end

  def show
    @services = Service.find(:all, :include => :polls, :order => 'name')
  end
end
