class Event < ActiveRecord::Base
  belongs_to :user
  has_many :notes, as: :noteable
  accepts_nested_attributes_for :notes

  validates_presence_of :user_id, :release_date, :event

  def start_time
    release_date
  end
end
