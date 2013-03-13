class SuggestionsController < ApplicationController
def new
  @suggestion = Suggestion.new
end

def create
  @suggestion =Suggestion.new(params[:suggestion])
  @suggestion.user = current_user
  @event = @suggestion.event
  if @suggestion.save
  	if @event.suggestions.first == @suggestion
  		redirect_to :controller => "events", :action => "step3", :id => @event.id
  	else
    redirect_to @event, notice: "Suggestion saved"
	 end
  else
    redirect_to :back
  end
end




end
