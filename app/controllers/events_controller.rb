class EventsController < ApplicationController
  before_action :ensure_unique_event, only: [:create]

  def new
    @event = Event.new
    @users = User.where.not('id = ?', current_user.id).pluck(:name)
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
    params.required(:event).permit(:description)
  end

  def ensure_unique_event
    if Event.find_by(description: params[:event][:description])
      flash.now[:info] = "It appears you had already created this event"
      @event = Event.new(event_params)
      render :new
    end
  end

  def create_attendees
    params[:event][:attendees].each do |name|
      User.find_by(name: name).attended_events << @event
    end
  end
end
