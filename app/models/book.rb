class Book < ActiveRecord::Base
  belongs_to :genre
  belongs_to :format
  has_many :users, through: :user_books
  has_many :user_books
  has_many :notes, as: :noteable

end
