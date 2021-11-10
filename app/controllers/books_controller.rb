class BooksController < ApplicationController


  def index
    @books = Book.left_joins(:favorites).group(:book_id).order('count(user_id) desc')
    @new_book = Book.new
    @user = User.find(current_user.id)
    @content = params["content"]
  end

  def show
    @new_book = Book.new
    @book = Book.includes(:book_comments).find(params[:id])
    @user = User.find(@book.user_id)
    @book_comment = BookComment.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have created book successfully."
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
        flash[:notice] = "You have updated book successfully."
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

  def time_range
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    time_range = from...to
  end



  def book_params
    params.require(:book).permit(:title, :body)
  end
end