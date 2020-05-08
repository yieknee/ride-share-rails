class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]
    @driver= Driver.find_by(id: driver_id)
    @trips = Trip.where(driver_id: driver_id)
    if @driver.nil?
      redirect_to root_path
      return
    end
  end
end
