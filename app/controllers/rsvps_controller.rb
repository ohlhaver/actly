class RsvpsController < ApplicationController
	
	def favor
		change_status(2)
	end

	def confirm
		change_status(1)
	end


	def decline
		change_status(4)
	end

	def maybe
		change_status(3)
	end

	def change_status(status)
		suggestion_id = params[:suggestion_id]
		@rsvp = Rsvp.find_or_create_by_user_id_and_suggestion_id(current_user.id, suggestion_id)
		@rsvp.status = status
		@rsvp.save
		redirect_to :back
	end



end
