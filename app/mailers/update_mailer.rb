class UpdateMailer < ActionMailer::Base
  default from: "\"stage.ly\" <update@stage.ly>"
  

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_mailer.suggestion.subject
  #
  def suggestion(suggestion, email, invitation)
    @suggestion = suggestion
    @author = suggestion.user
    @notes = suggestion.notes
    @subject = @author.name + ' added suggestion to ' + suggestion.event.title
    @event = suggestion.event
    @auth_token = invitation.auth_token if invitation
    mail :to => email, :subject => @subject
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_mailer.comment.subject
  #
  def comment(comment, email, invitation)
    @comment = comment
    @event = comment.event
    @user = comment.user
    @text = comment.text
    @subject = @user.name + " commented on " + @event.title
    @auth_token = invitation.auth_token if invitation
    mail :to => email, :subject => @subject
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_mailer.rsvp.subject
  #
  def rsvp(rsvp, email, invitation)
    @suggestion = rsvp.suggestion
    @user = rsvp.user
    @event = rsvp.suggestion.event
    @status = show_rsvp_status(rsvp)
    @subject = @user.name + " '" + @status + "' " + @suggestion.address + " @ " +  @suggestion.time.to_formatted_s(:short)
    @auth_token = invitation.auth_token if invitation
    mail :to => email, :subject => @subject
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

  def last_call(event, email, invitation)
    @event=event
    @subject = "Last call for " + @event.title
    @auth_token = invitation.auth_token if invitation
    mail :to => email, :subject => @subject

  end


  def decision(event, email, invitation)
    @event=event
    @suggestion = @event.suggestions.sort_by{|e| -e[:score]}.first
    @no_decision = true if @suggestion.score < 1
    @subject = "Final decision for " + @event.title
    @auth_token = invitation.auth_token if invitation
    mail :to => email, :subject => @subject
  end



end
