class Event < ActiveRecord::Base
  belongs_to :user
  has_many :notes, as: :noteable

  validates_presence_of :user_id

  def start_time
    release_date
  end
end
