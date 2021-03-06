 class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

    def search
    session[:search_results] = request.url
    @booksearch = Book.library_search(params[:search])
    @books_minus_yours = @booksearch.where.not(id: current_user.books.pluck(:id))
    @books = @books_minus_yours.page params[:page]
    if @books.count == 0
      case params[:type]
      when 'ISBN'
        isbn = 'isbn:' << params[:search]
        @books = GoogleBooks.search(isbn, {count: 10})
      when 'Author-Title'
        @books = GoogleBooks.search(params[:search], {count: 10})
      else
        @books = GoogleBooks.search(params[:search], {count: 10})
      end
      if @books.count == 0
        redirect_to new_book_path, notice: 'There are no books containing the search term(s). Please enter your book manually.'
      end
    end
  end

  def index
    @books = current_user.books.where(nil).order('title ASC').page params[:page]
    @books = @books.unread(current_user).uniq if params[:unread].present?
    @books = @books.reorder('user_books.created_at DESC') if params[:newest_first].present?
    if params[:search].present?
      @books = current_user.books.library_search(params[:search]).page params[:page]
      if !@books.present?
        redirect_to root_path, notice: 'There are no books containing the search term(s).'
      end
    end
  end

  def list
    @books = current_user.books.where(nil).order('title ASC').page(params[:page]).per(12)
    @books = @books.unread(current_user).uniq if params[:unread].present?
    @books = @books.reorder('user_books.created_at DESC') if params[:newest_first].present?
  end

  def show
    authorize! :read, @book
  end

  def new
    @book = Book.new
    authorize! :read, @book
  end

  def edit
    authorize! :update, @book
  end

  def create
    @book = current_user.books.create(book_params)
    authorize! :create, @book
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :update, @book
    @book.set_edittable
    if @book.update(book_params)
      redirect_to books_path, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def add_book
    @book = Book.find(params[:id])
    @book.user_books.create(user_id: current_user.id)
    authorize! :create, @book
    if @book.save
      redirect_to root_path, notice: 'Book was successfully added to your library.'
    else
      redirect_to request.referrer, notice: 'Book could not be added. Is it already in your library?'
    end
  end

  def add_gbook
    @book = current_user.books.create(book_params)
    authorize! :create, @book
    if @book.save
      redirect_to edit_book_path(@book), notice: 'Please add a genre and format, then save.'
    else
      redirect_to request.referrer, notice: 'Book could not be added. Is it already in your library?'
    end
  end

  def destroy
    authorize! :destroy, @book
    @book.destroy
      redirect_to session[:search_results]
  end

  private
    def set_book
      @book = current_user.books.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:isbn, :authors, :title, :description, :published_date, :genre_id, :format_id, :image_link, :series, :series_number, :edittable)
    end

end
