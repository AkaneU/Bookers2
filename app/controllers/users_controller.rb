class UsersController < ApplicationController
  before_action :action_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = Book.where(user_id: @user.id)
  end

  def index
    @new_book = Book.new
    @users = User.all
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  private

  def action_user
    @user = User.find(params[:id])
    if @user.id == current_user.id
      redirect_to edit_user_path(@user.id)
    else
      redirect_to users_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


end
