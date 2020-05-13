require "test_helper"

describe DriversController do
 
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      driver1 = Driver.create(name: 'Earl', vin: '123jdsf')
      driver2 = Driver.create(name: 'Bob', vin: '13j34f')
      # Act
      get(drivers_path)
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      Driver.delete_all
      # Act
      get(drivers_path)
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      driver = Driver.create(name: 'Bob', vin: '123abc')
      # Act
      get(driver_path(driver.id))
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      get(driver_path(123124124))
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get(new_driver_path)
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      expect{post(drivers_path, params: {driver:{name: 'Bob', vin: '123abc'}})}.must_differ 'Driver.count', 1
      must_respond_with :redirect
    end

    it "does not create a driver if the form data violates Driver validations, and responds with rendering new form again" do
      get(new_driver_path)
      expect{post(drivers_path, params: {driver:{name: 'Bob'}})}.wont_change 'Driver.count'
      must_respond_with :bad_request
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      driver = Driver.create(name: 'Bob', vin: '123abc')
     
      get(edit_driver_path(driver.id))
      
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
     
      get(edit_driver_path(123124213))
     
      must_respond_with :redirect
    
    end
  end

  describe "update" do
    before do
      Driver.create(name: "tom", vin: "abc123")
    end
    let (:new_driver_hash) {
      {
        driver: {
          name: "bob",
          vin: "def321",
        },
      }
    }
    it "can update an existing driver with valid information accurately, and redirect" do

      id = Driver.first.id
      expect {
        patch driver_path(id), params: new_driver_hash
      }.wont_change "Driver.count"
  
      must_respond_with :redirect
  
      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal new_driver_hash[:driver][:name]
      expect(driver.vin).must_equal new_driver_hash[:driver][:vin]
      
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      get(edit_driver_path(13421431))
      patch(driver_path({driver:{name: 'Bob', vin: '234bcd'}}))
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      
      driver = Driver.create(name: 'Bob', vin: '123abc')

      get(edit_driver_path(driver.id))
      patch(driver_path({driver:{name: 'Bob'}}))
     
      driver.vin.must_equal '123abc'
      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
     
      driver = Driver.create(name: 'Bob', vin: '123abc')
      
      expect {delete(driver_path(driver.id)) }.must_differ 'Driver.count', -1
      must_respond_with :redirect
    end

    it "does not change the db when the driver does not exist, then responds with " do
     
      driver = Driver.create(name: 'Bob', vin: '123abc')
     
      expect {delete(driver_path(143256)) }.must_differ 'Driver.count', 0
      must_respond_with :redirect
    end
  end

  describe "availability" do
    it "make unavailable driver available then change back to unavailable " do
      
      driver = Driver.create(id: 1, name: 'Bob', vin: '123abc', available: true)
    
      patch available_driver_path(1)
      new_driver = Driver.find_by(id: 1)
      new_driver.available.must_equal false
      patch(available_driver_path(1))
      driver = Driver.find_by(id: 1)
      driver.available.must_equal true

      must_respond_with :redirect

    end
  end
end
