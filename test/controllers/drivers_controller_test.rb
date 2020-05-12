require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      driver1 = Driver.create(name: 'Earl', vin: '123jdsf')
      driver2 = Driver.create(name: 'Bob', vin: '13j34f')
      # Act
      get(drivers_path)
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
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
      # Ensure that there is a driver saved
      driver = Driver.create(name: 'Bob', vin: '123abc')
      # Act
      get(driver_path(driver.id))
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      
      # Act
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
      # Arrange
      # Set up the form data
  
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      expect{post(drivers_path, params: {driver:{name: 'Bob', vin: '123abc'}})}.must_differ 'Driver.count', 1
      must_respond_with :redirect
    end

    it "does not create a driver if the form data violates Driver validations, and responds with rendering new form again" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      get(new_driver_path)
      # Act-Assert
      # Ensure that there is no change in Driver.count
      # Assert
      # Check that the controller redirects
      expect{post(drivers_path, params: {driver:{name: 'Bob'}})}.wont_change 'Driver.count'
      must_respond_with :bad_request
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: 'Bob', vin: '123abc')
      # Act
      get(edit_driver_path(driver.id))
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act
      get(edit_driver_path(123124213))
      # Assert
      must_respond_with :redirect
      #this renders the edit form again. Need to find a must_render
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
      ## OLD SAVING JUST IN CASE - TO DELETE ONCE YIENI APPROVES
      # # Arrange
      # # Ensure there is an existing driver saved
      # # Assign the existing driver's id to a local variable
      # # Set up the form data
      # driver = Driver.create(name: 'Bob', vin: '123abc')
      # params = {driver:{name: 'Bob', vin: '234bcd'}}
      # # Act-Assert
      # # Ensure that there is no change in Driver.count
      # get(edit_driver_path(driver.id)) 
      # patch(driver_path({driver:{name: 'Bob', vin: '234bcd'}}))
      # # Assert
      # # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # # Check that the controller redirected the user
      # expect(Driver.count).must_equal 1
      # expect(driver.vin).must_equal params[:driver][:vin]
      # must_respond_with :redirect

      id = Driver.first.id
      expect {
        patch driver_path(id), params: new_driver_hash
      }.wont_change "Driver.count"
  
      must_respond_with :redirect
  
      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal new_driver_hash[:driver][:name]
      expect(driver.vin).must_equal new_driver_hash[:driver][:vin]
      


#    THE BEFORE CODE FOR THE ABOVE TEST SAVING JUST IN CASE - TO DELETE ONCE YIENI APPROVES
# # Ensure there is an existing driver saved
# # Assign the existing driver's id to a local variable
# # Set up the form data
# driver = Driver.create(name: 'Bob', vin: '123abc')
# get(edit_driver_path(driver.id))
# params = {driver:{name: 'Bob', vin: '234bcd'}}
# # Act-Assert
# # Ensure that there is no change in Driver.count
# patch(driver_path(driver.id), params: params) 
# # Assert
# # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
# # Check that the controller redirected the user
# Driver.count.must_equal 1
# driver.vin.must_equal '234bcd'
# must_respond_with :redirect
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      get(edit_driver_path(13421431))
      # Act-Assert
      # Ensure that there is no change in Driver.count
      patch(driver_path({driver:{name: 'Bob', vin: '234bcd'}}))
      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      driver = Driver.create(name: 'Bob', vin: '123abc')
      get(edit_driver_path(driver.id))
      # Act-Assert
      # Ensure that there is no change in Driver.count
      patch(driver_path({driver:{name: 'Bob'}}))
      # Assert
      # Check that the controller redirects
      driver.vin.must_equal '123abc'
      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: 'Bob', vin: '123abc')
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
    
      # Assert
      # Check that the controller redirects
      expect {delete(driver_path(driver.id)) }.must_differ 'Driver.count', -1
      must_respond_with :redirect
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      driver = Driver.create(name: 'Bob', vin: '123abc')
      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      expect {delete(driver_path(143256)) }.must_differ 'Driver.count', 0
      must_respond_with :redirect
    end
  end
end
