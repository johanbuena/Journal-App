require "test_helper"

class TaskFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:user)
  end
  
  test "can create a task" do 
    post journal_tasks_path(journals(:journal).id),
      params: { task: {taskname: "Test Task", taskdescription: "Test Task Description", taskdeadline: Date.today, taskstatus: false} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can view a task" do  
    get journal_task_path(journals(:journal).id, tasks(:task).id)
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can edit a journal" do 
    patch journal_task_path(journals(:journal).id, tasks(:task).id),
      params: { task: {taskname: "test edit task", taskdescription: "task edit description", taskdeadline: Date.today + 2, taskstatus: true} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can delete a journal" do
    delete journal_task_path(journals(:journal).id, tasks(:task).id)
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
