class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    render json: @libraries, include: ['books'], status: :ok
  end

  def show
    @library = Library.includes(:books).find(params[:id])
    render json: @library, include: ['books'], status: :ok
  end
end