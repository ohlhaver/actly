class Comment < ActiveRecord::Base
  attr_accessible :event_id, :text, :user_id
  belongs_to :user
  belongs_to :event
  after_create :email_notification


  def email_notification
  		@invitations = event.invitations.where(:blocked => false)
		@author_invitation = Invitation.find_by_email_and_event_id(user.email, event.id )

		@invitations -= Array.wrap(@author_invitation)
    	@invitations.each do |i|
			UpdateMailer.delay.comment(self, i.email, i)
		end
		UpdateMailer.delay.comment(self, event.user.email) unless event.user == user
  end
end


