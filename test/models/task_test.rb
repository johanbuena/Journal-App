require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @journal = Journal.create(journal_name: "Journal One",
                              journal_description: ('x'*30),
                              user_id: users(:user).id)

    @task = Task.create(taskname: "Task One",
                        taskdescription: ('y'*30),
                        taskdeadline: Date.today,
                        journal_id: @journal.id,
                        user_id: users(:user).id)
  end

  test "should reject a task without a name" do
    @task.taskname = ''
    assert_not @task.valid?
  end

  test "should reject a task with a name that is longer than 20 chars" do
    @task.taskname = 'x' * 31
    assert_not @task.valid?
  end

  test "should reject a task without a description" do
    @journal.journal_description = ''
    assert_not @journal.valid?
  end

  test "should reject a task with a description length less than 10" do
    @task.taskdescription = 'x' * 9
    assert_not @task.valid?
  end

  test "should reject a task with a description length greater than 100" do
    @task.taskdescription = 'x' * 101
    assert_not @task.valid?
  end

  test "should reject a task without a deadline" do
    @task.taskdeadline = ''
    assert_not @task.valid?
  end

  test "should reject a task with a deadline past today" do
    @task.taskdeadline = Date.today - 1
    assert_not @task.valid?
  end
end
