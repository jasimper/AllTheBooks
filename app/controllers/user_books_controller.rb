class UserBooksController < ApplicationController
  before_action :set_user_book, only: [:new_note, :add_note, :has_read, :destroy]


  def new_note
    if @user_book.notes.present?

    else
      @user_book.notes.build
    end
  end

  def add_note
    respond_to do |format|
      if @user_book.update_attributes(book_notes_params)
        format.html { redirect_to root_path }
        format.json { render json: @book }
      else
        format.html { render :new_note }
        format.json { render json: @user_book.errors, status: :unprocessable_entity }
      end
    end
  end

  def has_read
    @user_book.toggle!(:has_read)
    @user_book.update_attributes(user_books_params)
      respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { render json: @book }
    end
  end

  def update
  end

  def destroy
    @user_book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully removed from your library.' }
      format.json { head :no_content }
    end
  end

private

  def set_user_book
    @user_book = UserBook.find(params[:id])
  end

  def user_books_params
    params.permit(user_books_attributes: [:has_read])
  end
  def book_notes_params
    params.require(:user_book).permit(notes_attributes: [:id, :noteable_id, :noteable_type, :info])
  end
end
