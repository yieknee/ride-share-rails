require "test_helper"

describe TripsController do

  before do
    passenger = Passenger.create!(name: "bob", phone_num:"12334556")
    driver = Driver.create!(name: "tom", vin:"asdfghjkl", available: true)
    trip_hash = {
      passenger_id: passenger.id,
      driver_id: driver.id,
      cost: 99,
      date: Date.today
    }

    @trip = Trip.create(trip_hash)
    
  end

  describe "show" do  
    before do
      @trip = Trip.first
    end

    it "shows a trip" do
      
      valid_trip_id = @trip.id
      get trip_path(valid_trip_id)
      must_respond_with :success
  
    end

    it "responds with redirect with an invalid trip id" do
      
      get(trip_path(123124124))
      # Assert
      must_respond_with :redirect
    end
  end

  describe "create" do 

    it "trip increase by one and redirects" do
    passenger = Passenger.create!(name: "bob", phone_num:"12334556")
    driver = Driver.create!(name: "tom", vin:"asdfghjkl", available: true)
      
    expect{post passenger_trips_path(passenger.id)}.must_differ "Trip.count", 1
    must_redirect_to passenger_path(passenger.id)
    end

  end

  describe "edit" do
    before do
      @trip = Trip.first
    end

    let (:new_trip_hash) {
      {
        driver: {
          rating: "3",
        },
      }
    }
    it "responds with success when getting the edit page for an existing, valid trip" do #passing
      # Arrange
      
      # Act
      get(edit_trip_path(@trip.id))
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing trip" do  #passing
      # Arrange
      # Act
      get(edit_trip_path(123124213))
      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    
    let (:new_trip_hash) {
      {
        driver: {
          rating: "3",
          passenger_id: 5,
          driver_id: 5,
          cost: 99,
          date: Date.today
        },
      }
    }
 
    it "will respond with not_found for invalid ids" do # passing
      id = -1
  
      expect {
        patch trip_path(id), params: new_trip_hash
      }.wont_change "Trip.count"
  
      must_respond_with :not_found
    end

  end

  describe "destroy" do 
    it "destroys the trip instance in db when trip exists, then redirects" do
     
      expect {delete(trip_path(@trip.id)) }.must_differ 'Trip.count', -1
      must_respond_with :redirect
    end

    it "does not change the db when the trip does not exist, then responds with " do
    
      expect {delete(trip_path(143256)) }.must_differ 'Trip.count', 0
      must_respond_with :redirect
    end
    
  end
end
