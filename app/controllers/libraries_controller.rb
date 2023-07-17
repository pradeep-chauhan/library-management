class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    render json: @libraries, include: ['books'], status: :ok
  end

  def show
    @library = Library.includes(:books).find(params[:id])
    render json: @library, include: ['books'], status: :ok
  end

  def create
    @library = Library.new(library_params)
    @library.save!
    render json: { library: @library }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    @library.update!(library_params)
    render json: { library: @library }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def exists
    @library = Library.find_by_id(params[:id])
    render json: { error: 'library is not found' }, status: :not_found unless @library.present?
  end

  def library_params
    params.require(:library).permit(:name)
  end
end