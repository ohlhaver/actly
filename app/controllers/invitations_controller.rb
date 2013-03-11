class InvitationsController < ApplicationController
	def add_invitees
		user_id = params[:user_id]
		event_id = params[:event_id]
		@event = Event.find(event_id)
		invitees = params[:invitees]
		invitees_array = invitees.split(',')
		invitees_array.each do |i|
			unless Invitation.find_by_email_and_event_id(i,event_id)
				invitation = Invitation.new
				invitation.email = i
				invitation.inviter_id = user_id
				invitation.event_id = event_id
				invitation.blocked = false
				invitation.save
				Contact.find_or_create_by_inviter_id_and_email(user_id, i)
			end
		end
		redirect_to @event
	end

	def invite_contacts
		user_id = params[:user_id]
		event_id = params[:event_id]
		@event = Event.find(event_id)
		invitees = params[:invitees]
		
		invitees.each do |i|
			email= Contact.find_by_id(i).email
			unless Invitation.find_by_email_and_event_id(email, event_id)
				invitation = Invitation.new
				invitation.email = email
				invitation.inviter_id = user_id
				invitation.event_id = event_id
				invitation.blocked = false
				invitation.save
			end
			
		end
		redirect_to @event
	end

	def unfollow
		invitation_id = params[:invitation_id]
		@invitation = Invitation.find_by_id(invitation_id)
		@invitation.blocked = true
		@invitation.save
		redirect_to :back
	end

	def follow
		invitation_id = params[:invitation_id]
		@invitation = Invitation.find_by_id(invitation_id)
		@invitation.blocked = false
		@invitation.save
		redirect_to :back
	end


end
