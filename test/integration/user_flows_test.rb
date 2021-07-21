require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = {
             firstname: "testfirstname",
             lastname: "testlastname",
             email: "testemail@avion.com",
             password: "123456",
             password_confirmation: "123456"
            }
  end

  test "can create a user" do 
    post user_registration_path,
      params: { user: @user } 
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "user can login" do
    @registered_user = { email: users(:user).email, password: "123456" }
    post user_session_path,
      params: { user: @registered_user }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
  
end
