class ApplicationController < ActionController::Base
  protect_from_forgery

  private

	def current_user
	  	@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end
		helper_method :current_user

	def authorize
		store_location
		if params[:inv]
			inv=params[:inv]
			redirect_to "/auth/#{inv}" if current_user.nil?
		else
		redirect_to login_url, alert: "Not authorized" if current_user.nil?
		end
	end

	def redirect_back_or(default)
   		redirect_to(session[:return_to] || default)
   	 	session.delete(:return_to)
  	end

	def store_location
	  	session[:return_to] = request.url
	end

	def invited_user
      	@event = Event.find(params[:id])
      	redirect_to root_path, alert: "Not authorized" unless Invitation.find_by_email_and_event_id(current_user.email, @event.id) or current_user == @event.user
    end

end
