class Note < ActiveRecord::Base
  belongs_to :noteable, polymorphic: true

  validates :info, length: {in: 0..240}
end
