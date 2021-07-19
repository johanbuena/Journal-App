require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create(email: 'testuser@gmail.com',
                        password: '123456789',
                        password_confirmation: '123456789',
                        firstname: 'first name',
                        lastname: 'last name')
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "user should reject empty email" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "user should reject empty password" do
    @user.password = ''
    assert_not @user.valid?
  end

  test "user should reject empty password_confirmation" do
    @user.password_confirmation = ''
    assert_not @user.valid?
  end

  test "user should reject empty first_name" do
    @user.firstname = ''
    assert_not @user.valid?
  end

  test "user should reject empty last_name" do
    @user.lastname = ''
    assert_not @user.valid?
  end

  test "user should reject duplicated emails" do
    another_user = User.create(email: 'testuser@gmail.com',
                               password: '123456',
                               password_confirmation: '123456',
                               firstname: 'firstname',
                               lastname: 'lastname')

    assert_not another_user.valid?
  end

  test "user should reject unmatched password and confirmation password" do
    @user.password_confirmation = '987654321'
    assert_not @user.valid?
  end

  test "user should accept correct password" do
    assert @user.valid_password?('123456789')
  end

  test "user should reject incorrect password" do
    assert_not @user.valid_password?('fasdfasfsadf')
  end

  test "user should reject passwords that is less than 6 chars in length" do
    @user.password = '12345'
    @user.password_confirmation = '12345'
    assert_not @user.valid?
  end

end
