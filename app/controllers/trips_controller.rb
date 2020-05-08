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
    @trip = Trip.new(driver_id: @driver_id, passenger_id: @passenger.id  , date: @date, rating: @rating, cost: @cost)
    if @trip.save
      redirect_to passenger_path(@trip.passenger_id)
      return
    else 
      redirect_to passenger_path(@trip.passenger_id)
      return
    end
  end

  
  
end
