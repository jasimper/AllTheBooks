class User < ActiveRecord::Base

  has_many :user_books, class_name: UserBook
  has_many :books, through: :user_books
  has_many :events

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
