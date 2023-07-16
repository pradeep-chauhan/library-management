class BooksController < ApplicationController
  def index
    @library = Library.find(params[:library_id])
    @books = @library.books

    @books.each do |book|
      if book.available?
        book.user = User.find(book.user_id)
      end
    end

    render json: { books: @books }, status: :ok
  end

  def show
    @book = Book.find_by(id: params[:book_id])

    if @book && @book.available?
      @book.user = User.find(book.user_id)
    end

    render json: { book: @book }, status: :ok
  end
end