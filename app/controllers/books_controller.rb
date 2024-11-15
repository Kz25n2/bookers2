class BooksController < ApplicationController
  def index
    @new_book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(book.id)
    else
      @new_book = @book
      @books = Book.all
      render :index
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(book.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "You hava destroyed book successfully."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end

end
