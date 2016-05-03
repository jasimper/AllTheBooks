class UserBooksController < ApplicationController
  before_action :set_user_book, only: [:new_note, :add_note, :has_read, :destroy]


  def new_note
    authorize! :read, @user_book
    if @user_book.notes.present?

    else
      @user_book.notes.build
    end
  end

  def add_note
    authorize! :update, @user_book
    if @user_book.update_attributes(book_notes_params)
      redirect_to root_path, notice: 'Your note was successfully created.'
    else
      render :new_note
    end
  end

  def has_read
    authorize! :update, @user_book
    @user_book.toggle!(:has_read)
    @user_book.update_attributes(user_books_params)
      redirect_to request.referrer
  end

  def update
    authorize! :update, @user_book
  end

  def destroy
    authorize! :destroy, @user_book
    @user_book.destroy
      redirect_to books_url, notice: 'Book was successfully removed from your library.' 
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
