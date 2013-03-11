class Suggestion < ActiveRecord::Base
  attr_accessible :address, :notes, :time, :event_id
  belongs_to :user
  belongs_to :event
  has_many :rsvps
  has_many :confirmed_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 1]
  has_many :favoring_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 2]
  has_many :declining_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 4]
  has_many :maybe_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 3]
  after_create :email_notification
  after_save :update_lastcall


  def email_notification
  	UpdateMailer.suggestion(self).deliver
  end

  def update_lastcall
    @event = self.event
    if @event.lastcall == nil or @event.lastcall >= (self.time - 1.hour)
      if Time.now <= (self.time - 2.hours)
        @event.lastcall = (self.time - 1.hour)
      else
        @event.lastcall = self.time
      end
      @event.save
    end

  end


end
