class Book < ActiveRecord::Base
  has_many :user_books, class_name: UserBook
  has_many :users, through: :user_books
  belongs_to :genre
  belongs_to :format


  validates :authors, :title, presence: true,
                             length: {in: 1..80}


  # erroring if blank saying isbn is already taken
  validates :isbn, uniqueness: true, allow_blank: true, allow_nil: true

  # need to validate series boolean and field


  def self.library_search(search)
    if search
      where("authors ILIKE ? OR title ILIKE ?", "%#{search}%", "%#{search}%")

    end
  end

  def library_book(current_user, book)
    UserBook.where("user_id = ? AND book_id = ?", current_user.id, book.id)
  end

  
end
