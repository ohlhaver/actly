class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :events
  has_many :contacts, foreign_key: "inviter_id"
  has_many :invitations, foreign_key: "invitee_id"
  before_save { |user| user.email = email.downcase }
  after_save :update_invitations
  after_save :update_contacts
  before_create { generate_token(:auth_token) }
  
  validates :name, presence: true, length: { maximum: 50 }
  #                   uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #validates :password, length: { minimum: 4 }
  #validates :password_confirmation, presence: true



  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.delay.password_reset(self)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def email_invitation_events
  	invitations = Invitation.where(:email => self.email)
  	events = []
  	invitations.each do |invitation|
  		events += Array.wrap(invitation.event)
  	end
  	return events
  end

  def update_invitations
  	invitations = Invitation.where(:email => self.email)
  	  invitations.each do |invitation|
  		if invitation.invitee == nil
  			invitation.invitee = self
  			invitation.update_label
  			invitation.save 
  			
  		end
  	end

  end

  def update_contacts
  	contacts = Contact.where(:email => self.email)
  	  contacts.each do |contact|
  		if contact.invitee == nil
  			contact.invitee = self
  			contact.update_label
  			contact.save 
  		end
  	end
  end


end
