class UsersController < ApplicationController


  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      redirect_to books_path
    else
      redirect_to root_path
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
