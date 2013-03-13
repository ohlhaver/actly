class EventsController < ApplicationController
before_filter :authorize
before_filter :invited_user, only: [:show]

def new
  @event = Event.new
end

def create
  @event = current_user.events.build(params[:event])
  if @event.save
    redirect_to :action => "step2", :id => @event.id
  else
    render "new"
  end
end

def show
	@event = Event.find(params[:id])
  @ranked_suggestions = @event.suggestions.sort_by{|e| -e[:score]}
	@suggestion = Suggestion.new
	@invitation = Invitation.find_by_email_and_event_id(current_user.email, @event.id)
  @comments = @event.comments
end

def step2
  @event = Event.find(params[:id])
  @suggestion = Suggestion.new
end

def step3
  @event = Event.find(params[:id])
end

def add_comment
  @event = Event.find(params[:id])
      comment = Comment.new
        comment.text = params[:comment]
        comment.user_id = current_user.id
        comment.event_id = @event.id
      comment.save
      redirect_to :back
end

end

