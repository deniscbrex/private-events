class EventsController < ApplicationController
  before_action :fetch_users, only: [:new, :create]
  before_action :ensure_logged_in, only: [:show]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      create_attendees
      flash[:success] = "Event created successfully!"
      redirect_to events_url
    else
      flash[:danger] = "Error creating this event!"
      render :new
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def index
    @events = Event.all
  end

  private

  def event_params
    params.required(:event).permit(:description, :date, :location)
  end

  def create_attendees
    params[:event][:attendees].each do |name|
      if @user = User.find_by(name: name).attended_events
        @user << @event
      end
    end
  end

  def fetch_users
    @users = User.other_users(current_user).pluck(:name)
  end
end
