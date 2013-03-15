class StaticPagesController < ApplicationController
  def home
  	if current_user
		@events = (current_user.events + current_user.email_invitation_events).uniq.find_all{|i| i.earliest >= 2.hours.ago && i.suggestions.empty? == false}.sort_by{|e| e[:earliest]}
  	end
  end
end
