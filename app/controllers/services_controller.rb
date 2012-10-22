class ServicesController < ApplicationController
  def index
    @title = 'All services'
    @services = Service.all
  end

  def show
    redirect_to :action => 'edit'
  end

  def new
    @title = 'Add a new service'
    @service = Service.new
  end

  def create
    @service = Service.new params[:service]
    if @service.save
      redirect_to service_path(@service)
    else
      flash[:error] = 'There was a problem creating a new service.'
      flash[:errors] = @service.errors
      redirect_to :action => 'new'
    end
  end

  def edit
    @service = Service.find params[:id]
    @service.poll_webservice
  end

  def update
    @service = Service.find params[:id]
    if @service.update_attributes(params[:service])
      redirect_to :action => 'index'
    else
      flash[:error] = "There was a problem saving your changes to #{@service.name}."
      flash[:errors] = @service.errors
      redirect_to :action => 'edit'
    end
  end

  def destroy
    @service = Service.find params[:id]
    if @service.destroy
      redirect_to :action => 'index'
    else
      flash[:error] = "There was a problem deleting the service #{@service.name}."
      flash[:errors] = @service.errors
      redirect_to :action => 'show'
    end
  end
end
