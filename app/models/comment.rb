class Comment < ActiveRecord::Base
  attr_accessible :event_id, :text, :user_id
  belongs_to :user
  belongs_to :event
  after_create :email_notification


  def email_notification
  	UpdateMailer.delay.comment(self)
  end
end
