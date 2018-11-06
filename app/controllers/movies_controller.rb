class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: jsonify(movies), status: :ok #response code
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: jsonify(movie), status: :ok #response code
    else
      # options
      # head :not_found
      # render json: {}, status: :not_found
      render_error(:not_found, { movie_id: ["No such movie"] } )
    end
  end

  def create
    movie = Movie.new(movie_params)
    # binding.pry
    if movie.save
      render json: { id: movie.id }, status: :ok
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:id, :title, :overview, :release_date, :inventory)
  end

  def jsonify(movie_data)
    return movie_data.as_json(only: [:id, :title, :overview, :release_date, :inventory])
  end
end
