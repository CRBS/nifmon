class DashboardController < ApplicationController
  def edit
  end

  def show
    @services = Service.all :include => :polls
  end
end
