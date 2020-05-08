class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip= Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
end
