class Book < ActiveRecord::Base
  has_many :user_books, class_name: UserBook
  has_many :users, through: :user_books
  belongs_to :genre
  belongs_to :format


  validates :author, :title, presence: true,
                             length: {in: 2..80}

  validates :isbn, uniqueness: true


  def self.library_search(search)
    if search
      where("author ILIKE ? OR title ILIKE ?", "%#{search}%", "%#{search}%")

    end
  end
end
