class Event < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :user
  has_many :suggestions
  has_many :invitations
  has_many :followers, through: :invitations, source: :invitee, :conditions => ['invitations.blocked =?',false]
  validates :title, presence: true, length: { maximum: 50 }
  after_create :set_last_call

  def set_last_call
  	self.lastcall=1.year.from_now
  	self.save
  end
end
