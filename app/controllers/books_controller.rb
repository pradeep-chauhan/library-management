class BooksController < ApplicationController
  before_action :exists, only: %i[update show]

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
    if @book && @book.available?
      @book.user = User.find_by(id: @book.user_id)
    end
    render json: @book, include: ['user'], status: :ok
  end

  def create
    @book = Book.new(book_params)
    @book.library = Library.find_by_id(params[:library_id])
    @book.save!
    render json: { book: @book }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    @book.update!(book_params)
    render json: { book: @book }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def checkout
    @book.checkout(params[:book][:user_id])
    render json: { book: @book }, status: :ok
  end

  private

  def exists
    @book = Book.find_by_id(params[:id])
    render json: { error: 'book is not found' }, status: :not_found unless @book.present?
  end

  def book_params
    params.require(:book).permit(:title, :available)
  end
end