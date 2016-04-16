class BooksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :add_book, :destroy]

  def search
    @books = Book.library_search(params[:search]).paginate(page: params[:page], per_page: 6)
    if !@books.present?
      @books = GoogleBooks.search(params[:search], {:count => 10})
      if !@books.present?
        redirect_to new_book_path, notice: 'There are no books containing the search term(s). Please enter your book manually.'
      end
    end
  end

  def index
    @user = current_user
    if params[:search].present?
      @books = current_user.books.library_search(params[:search]).paginate(page: params[:page], per_page: 6)
      if !@books.present?
        redirect_to root_path, notice: 'There are no books containing the search term(s).'
      end
    else
      @books = @user.books.paginate(page: params[:page], per_page: 6).order('id DESC')
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit

  end

  def create
    @book = current_user.books.create(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_book
    # need to add validation so a combo of user/book cannot be added twice
    @book.user_books.create(user_id: current_user.id)
    respond_to do |format|
      if @book.save
        format.html { redirect_to root_path, notice: 'Book was successfully added to your library.' }
        format.json { render :index, status: :success}
      else
        format.html { redirect_to request.referrer, notice: 'Book could not be added. Is it already in your library?' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = current_user.books.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:isbn, :author, :title, :description, :pub_date, :genre_id, :format_id, :image_url, :series, :series_num)
    end


end
