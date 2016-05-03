class EventsController < ApplicationController

before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events.order('release_date ASC')
    @partial = params[:view] || "calendar"

  end

  def show
    authorize! :read, @event
  end

  def new
    @event = current_user.events.new
    authorize! :read, @event
    @event.notes.build

  end

  def edit
    authorize! :read, @event
    if !@event.notes.present?
      @event.notes.build
    end
  end


  def create
    @event = current_user.events.create(event_params)
    authorize! :create, @event
    if @event.save
    redirect_to events_path, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, @event
    if @event.update_attributes(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @event
    @event.destroy
      redirect_to events_url, notice: 'The Event was successfully destroyed.'
  end

  private
    def set_event
      @event = current_user.events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event, :release_date, notes_attributes: [:id, :noteable_id, :noteable_type, :info])
    end
end
