class Event < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :user
  has_many :suggestions
  has_many :invitations
  has_many :comments
  has_many :followers, through: :invitations, source: :invitee, :conditions => ['invitations.blocked =?',false]
  validates :title, presence: true, length: { maximum: 50 }
  after_create :set_earliest

  def set_earliest
  	self.earliest=1.year.from_now
  	self.save
  end
end
