class UserBooksController < ApplicationController


  # def update
  #   @user_book = UserBooks.find(params[:id])
  #   if @user_book.update_attributes(user_books_params)
  #     redirect_to books_path
  #   else
  #     redirect_to root_path
  #   end
  # end

  def has_read
    @user_book = current_user.user_books.find(params[:id])
    @user_book.toggle!(:has_read)
    @user_book.update_attributes(user_books_params)
      respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { render json: @book }
    end
  end

private

  def user_books_params
    params.permit(:has_read)
  end
end
