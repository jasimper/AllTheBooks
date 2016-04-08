class BooksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def search
  end
  # GET /books
  # GET /books.json
  def index
    if params[:search].present?
      @books = Book.search(params[:search]).paginate(page: params[:page], per_page: 6)
      if !@books.present?
        redirect_to root_path, notice: 'There are no books containing the search term(s).'
      end
    else
      @books = current_user.books.paginate(page: params[:page], per_page: 6)
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
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

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
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

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :author, :title, :description, :pub_date, :genre_id, :format_id, :image_url, :series, :series_num)
    end
end
