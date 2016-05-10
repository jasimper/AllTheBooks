class Event < ActiveRecord::Base
  belongs_to :user
  has_many :notes, as: :noteable, dependent: :destroy
  accepts_nested_attributes_for :notes

  validates_presence_of :user_id, :release_date, :event

  def start_time
    release_date
  end

  def self.not_past
    self.where('release_date >= ?', Date.current)
  end
end
