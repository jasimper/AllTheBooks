class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :notes, as: :noteable, dependent: :destroy
  accepts_nested_attributes_for :notes

  validates_presence_of [:user_id, :book_id]
  # validation works, but message doesn't appear
  validates :book_id, uniqueness: { scope: [:user_id], message: " is already in your library"}

end
