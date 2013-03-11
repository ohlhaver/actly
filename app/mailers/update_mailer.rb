class UpdateMailer < ActionMailer::Base
  default from: "from@example.com"
  

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_mailer.suggestion.subject
  #
  def suggestion(suggestion)
    @suggestion = suggestion
    @author = suggestion.user
    @notes = suggestion.notes
    @subject = @author.name + ' added suggestion to ' + suggestion.event.title
    @event = suggestion.event
    followers =  (@event.followers + Array.wrap(@event.user)).uniq
    followers -= Array.wrap(@author)
    receipients =  followers.collect(&:email).join(",")
    mail :to => "event_followers@stage.ly", :bcc => receipients, :subject => @subject
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_mailer.comment.subject
  #
  def comment
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_mailer.rsvp.subject
  #
  def rsvp(rsvp)
    @suggestion = rsvp.suggestion
    @user = rsvp.user
    @event = rsvp.suggestion.event
    @status = show_rsvp_status(rsvp)
    @subject = @user.name + " '" + @status + "' " + @suggestion.address + " @ " +  @suggestion.time.to_formatted_s(:short)
    followers =  (@event.followers + Array.wrap(@event.user)).uniq
    followers -= Array.wrap(@user)
    receipients =  followers.collect(&:email).join(",")
    mail :to => "event_followers@stage.ly", :bcc => receipients, :subject => @subject
  end

  def show_rsvp_status(rsvp)
    status = rsvp.status
    if status == 1
      "confirmed"
    elsif status == 2
      "favors"
    elsif status == 3
      "might attend"
    elsif status == 4
      "declined"
    else
      ""
    end
    
  end
end
