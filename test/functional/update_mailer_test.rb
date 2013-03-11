require 'test_helper'

class UpdateMailerTest < ActionMailer::TestCase
  test "suggestion" do
    mail = UpdateMailer.suggestion
    assert_equal "Suggestion", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "comment" do
    mail = UpdateMailer.comment
    assert_equal "Comment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "rsvp" do
    mail = UpdateMailer.rsvp
    assert_equal "Rsvp", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
