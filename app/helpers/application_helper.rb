module ApplicationHelper
	def show_status(suggestion)
		status = Rsvp.find_by_user_id_and_suggestion_id(current_user.id, suggestion.id).status if Rsvp.find_by_user_id_and_suggestion_id(current_user.id, suggestion.id) 
		if status == 1
			"confirmed"
		elsif status == 2
			"favored"
		elsif status == 3
			"maybe"
		elsif status == 4
			"declined"
		else
			""
		end
	end



	def get_status(suggestion)
		Rsvp.find_by_user_id_and_suggestion_id(current_user.id, suggestion.id).status if Rsvp.find_by_user_id_and_suggestion_id(current_user.id, suggestion.id)
	end

	def rsvp_list(suggestion, status)

	end

	def flash_class(level)
	    case level
	    when :notice then "alert alert-info"
	    when :success then "alert alert-success"
	    when :error then "alert alert-error"
	    when :alert then "alert alert-error"
	    end
  	end
end
