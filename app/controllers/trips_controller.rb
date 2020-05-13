class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def create
    passenger_id = params[:passenger_id]
    driver = Driver.available_driver
    trip = Trip.new_trip(passenger_id, driver)
    if trip.save
      driver.available = false
      driver.save
      redirect_to passenger_path(passenger_id)
      return
    else
      redirect_to passenger_path(passenger_id), notice: "Failed to create new trip"
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trip_path
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to passenger_path (@trip.passenger_id)
      return
    else 
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    passenger_id = params[:passenger_id]
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end

    @trip.destroy
    redirect_to passenger_path(@trip.passenger_id) 
    return
    
  end

  private

  def trip_params
    return params.require(:trip).permit(:rating)
  end
  
end
