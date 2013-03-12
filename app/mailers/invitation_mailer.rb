class InvitationMailer < ActionMailer::Base
  default from: "\"stage.ly\" <update@stage.ly>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invitation.subject
  #
  def invitation
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def invitation(invitation)
    
    @inviter = invitation.inviter
    @subject = invitation.inviter.name + ' invited you to ' + invitation.event.title
    @event = invitation.event
    mail :to => invitation.email, :subject => @subject
  end

end
