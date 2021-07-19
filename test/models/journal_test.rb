require "test_helper"

class JournalTest < ActiveSupport::TestCase
  setup do
    @journal = Journal.create(journal_name: "Journal One",
                              journal_description: ('x'*20),
                              user_id: users(:user).id)
  end

  test "should reject a journal without a name" do
    @journal.journal_name = ''
    assert_not @journal.valid?
  end

  test "should reject a journal with a name that is longer than 20 chars" do
    @journal.journal_name = 'x' * 21
    assert_not @journal.valid?
  end

  test "should reject a journal without a description" do
    @journal.journal_description = ''
    assert_not @journal.valid?
  end

  test "should reject a journal with a description length less than 10" do
    @journal.journal_description = 'x' * 9
    assert_not @journal.valid?
  end

  test "should reject a journal with a description length greater than 100" do
    @journal.journal_description = 'x' * 101
    assert_not @journal.valid?
  end

end
