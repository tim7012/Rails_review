class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy, :dashboard]

  def index
    #@events = Event.all
    if params[:keyword]
      @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
    else
      @events = Event.all
    end

    if params[:order]
      sort_by = (params[:order] == 'name') ? 'name' : 'id'
      @events = @events.order(sort_by)
    end
    @events = @events.page(params[:page]).per(5)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
      flash[:notice] = "event was successfully created"
    else
      render new_event_path
    end
  end

  def latest
    @events = Event.order("id DESC").limit(3)
  end

  def show
    @page_title = @event.name
  end

  def dashboard

  end

  def edit

  end

  def update
    if
      @event.update(event_params)
      redirect_to event_path(event_params)
      flash[:notice] = "event was successfully updated"
    else
      render event_path(@event)
    end
  end

  def destroy
    @event.destroy

    redirect_to events_path
    flash[:alert] = "event was successfully deleted"
  end

  def bulk_update
    ids = Array(params[:ids])
    events = ids.map{|i| Event.find_by_id(i)}.compact

    if params[:commit] == "Delete"
      events.each {|e| e.destroy}
    elsif params[:commit] =="Publish"
      events.each {|e| e.update(:status => "published")}
    end
    redirect_to :back
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :status, :category_id, :group_ids => [])
  end


end
