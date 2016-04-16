class EventsController < ApplicationController

before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events.order('release_date ASC')
    @partial = params[:view] || "calendar"

  end

  def show
  end

  def new
    @event = current_user.events.new
    @event.notes.build

  end

  def edit
    if !@event.notes.present?
      @event.notes.build
    end
  end


  def create
    @event = current_user.events.create(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'The Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = current_user.events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event, :release_date, notes_attributes: [:id, :noteable_id, :noteable_type, :info])
    end
end
