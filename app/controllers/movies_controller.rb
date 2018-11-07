class MoviesController < ApplicationController
  def index
    movies = Movie.all
    # if movies
    render json: jsonify(movies), status: :ok #response code
    # else
    #   render_errors(:not_found, { movies: ["No movies found."]})
    # end
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: jsonify(movie), status: :ok #response code
      # render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
    else
      # options
      # head :not_found
      # render json: {}, status: :not_found
      render_error(:not_found, { movie_id: ["No such movie"] } )
    end
  end

  def create
    # binding.pry
    movie = Movie.new(movie_params)

    # binding.pry
    if movie.save
      render json: { id: movie.id }, status: :ok
      # render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end

  private

  def movie_params
<<<<<<< HEAD
    # removed .require(:movie) and this fixed smoke tests
    params.permit(:title, :overview, :release_date, :inventory) #, :available_inventory
=======
    # binding.pry
    params.permit(:title, :overview, :release_date, :inventory,  :available_inventory)
>>>>>>> fecf9952f581f0cf37ebc96a9ef6c5f6a722fc75
  end

  def jsonify(movie_data)
    return movie_data.as_json(only: [:id, :title, :overview, :release_date, :inventory, :available_inventory])
  end
end
