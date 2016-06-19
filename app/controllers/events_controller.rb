class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  def index
    @events = Event.all

  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
    else
      render new_event_path
    end
  end

  def show
    @page_title = @event.name
  end

  def edit

  end

  def update
    if
      @event.update(event_params)
      redirect_to events_path
    else
      render event_path(@event)
    end
  end

  def destroy
    @event.destroy

    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description)
  end


end
