class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :notes, as: :noteable

end
