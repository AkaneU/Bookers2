class BooksController < ApplicationController


  def index
    @new_book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@new_book.id)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end


  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    else
      if @book.update(book_params)
        flash[:notice] = "Book was successfully updated."
        redirect_to book_path(@book.id)
      else
        render :edit
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
      @book.destroy
      redirect_to books_path
    else
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end