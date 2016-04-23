 class BooksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def search
    session[:search_results] = request.url
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
    authorize! :read, @book

  end

  def new
    @book = Book.new
    authorize! :read, @book
  end

  def edit
    authorize! :read, @book
  end

  def create
    authorize! :create, @book
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
    authorize! :update, @book
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
    @book = Book.find(params[:id])
    @book.user_books.create(user_id: current_user.id)
    authorize! :create, @book
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

  def add_gbook
    @book = current_user.books.create(book_params)
    authorize! :create, @book
    respond_to do |format|
      if @book.save
        format.html { redirect_to edit_book_path(@book), notice: 'Please add a genre and format, then save.' }
        format.json { render :index, status: :success}
      else
        format.html { redirect_to request.referrer, notice: 'Book could not be added. Is it already in your library?' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    authorize! :destroy, @book
    @book.destroy
    respond_to do |format|
      format.html { redirect_to session[:search_results], notice: 'Book was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = current_user.books.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:isbn, :authors, :title, :description, :published_date, :genre_id, :format_id, :image_link, :series, :series_number)
    end

end
