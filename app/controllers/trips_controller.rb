class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip= Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def create
    passenger_id = params[:passenger_id]
    avilable_drivers = Driver.where(available: true)
    driver = avilable_drivers[0]
    trip = Trip.new_trip(passenger_id, driver)
    if trip.save
      driver.available = false
      driver.save
      redirect_to passenger_path(passenger_id)
      return
    else
      head :not_found
      return
    end
  end
  
end
