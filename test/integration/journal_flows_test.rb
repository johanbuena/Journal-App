require "test_helper"

class JournalFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:user)
  end

  test "can see the home page" do
    get journals_path
    assert_select "title", 1,"journals#index"
  end
  
  test "can create a journal" do 
    post journals_path,
      params: { journal: {journal_name: "Test Journal", journal_description: "Test Journal Description"} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can view a journal" do  
    get journal_path(journals(:journal).id)
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can edit a journal" do 
    patch journal_path(journals(:journal).id),
      params: { journal: {journal_name: "test edit journal", journal_description: "test edit journal description"} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can delete a journal" do
    delete journal_path(journals(:journal).id)
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

end
