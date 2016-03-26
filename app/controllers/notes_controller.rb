class NotesController < ApplicationController
  # This is all Ryan Bates of RailsCast fame.
  # I am not nearly smart enough to come up with this on my own.

  def create
      @noteable = find_noteable
      @note = @noteable.notes.build(note_params)
      if @note.save
        flash[:notice] = "Note successfully created."
        redirect_to :id => nil
      else
        render :action => 'new'
      end
  end

  private

  def find_noteable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def note_params
      params.require(:note).permit(:info, :noteable_id, :noteable_type)
    end
end
