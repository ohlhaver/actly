class Suggestion < ActiveRecord::Base
  attr_accessible :address, :notes, :time, :event_id
  belongs_to :user
  belongs_to :event
  has_many :rsvps
  has_many :confirmed_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 1]
  has_many :favoring_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 2]
  has_many :declining_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 4]
  has_many :maybe_users, through: :rsvps, source: :user, :conditions => ['rsvps.status =?', 3]
  validates :address, presence: true
  validate :time_in_future
  after_create :email_notification
  after_create :update_earliest
  after_initialize :init

  def time_in_future
    unless time.future?
      errors.add(:time, "Selected time needs to be in the future")
    end
  end

  def init
      self.score  ||= 0         
  end

  def email_notification
  	UpdateMailer.delay.suggestion(self)
  end

  def update_earliest
    @event = self.event
    if @event.earliest == nil or @event.earliest >= self.time
        @event.earliest = self.time
        @event.save
        update_lastcall (@event)
    end
  end

  def update_lastcall(event)
    distance = event.earliest - Time.now
    event.lastcall = event.earliest - (distance/2)
    event.decision = event.earliest - (distance/4)
    event.save
    generate_lastcall_email(event)
    generate_decision_email(event)
  end

  def generate_lastcall_email(event)
    destroy_old_email(event)
    job = UpdateMailer.delay(:run_at => event.lastcall).last_call(event)
    event.lastcall_job_id = job.id
    event.save
  end

  def destroy_old_email(event)
    if event.lastcall_job_id
      old_job = Delayed::Job.find_all_by_id(event.lastcall_job_id).first 
      old_job.destroy if old_job
    end
  end


  def generate_decision_email(event)
    destroy_old_decision_email(event)
    job = UpdateMailer.delay(:run_at => event.decision).decision(event)
    event.decision_job_id = job.id
    event.save
  end

  def destroy_old_decision_email(event)
    if event.lastcall_job_id
      old_job = Delayed::Job.find_all_by_id(event.decision_job_id).first 
      old_job.destroy if old_job
    end
  end

  def update_score
    
    score = 0  
    self.rsvps.each do |rsvp|
    
      if rsvp.status == 1
        score += 11
      elsif rsvp.status == 2
        score += 10
      elsif rsvp.status == 4
        score -= 1
      end
      self.score = score
      self.save
    end
  end




end
