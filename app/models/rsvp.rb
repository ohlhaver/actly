class Rsvp < ActiveRecord::Base
  attr_accessible :status, :suggestion_id, :user_id
  belongs_to :user
  belongs_to :suggestion
  after_save :email_notification

  def email_notification
  	UpdateMailer.rsvp(self).deliver
  end
end
