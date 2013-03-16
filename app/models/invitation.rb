class Invitation < ActiveRecord::Base
  attr_accessible :event_id, :invitee_id
  belongs_to :event
  belongs_to :invitee, class_name: "User"
  belongs_to :inviter, class_name: "User"
  before_create { generate_token(:auth_token) }
  after_create :email_invitation
  after_create :find_invitee_user
  before_save { |invitation| invitation.email = email.downcase }
  #after_save :update_label

  def find_invitee_user
  	user = User.find_by_email(self.email)
  	if user
  		self.invitee = user
  		self.save
  		update_label
  	end
  end

  def update_label
  	if self.invitee
  		self.label = self.invitee.name
  	else
  		self.label = self.email
  	end
  	self.save

  end

  def email_invitation
  	InvitationMailer.delay.invitation(self)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
