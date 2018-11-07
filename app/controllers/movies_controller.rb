class MoviesController < ApplicationController
  def index
    movies = Movie.all
<<<<<<< HEAD
    # if movies
    render json: jsonify(movies), status: :ok #response code
    # else
    #   render_errors(:not_found, { movies: ["No movies found."]})
    # end
=======
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok #response code
>>>>>>> 1a51ef16ab677427f623405f48a4ff3a5e8edaab
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
<<<<<<< HEAD
    params.permit(:title, :overview, :release_date, :inventory,  :available_inventory)
>>>>>>> fecf9952f581f0cf37ebc96a9ef6c5f6a722fc75
=======
    params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
>>>>>>> 1a51ef16ab677427f623405f48a4ff3a5e8edaab
  end

  def jsonify(movie_data)
    return movie_data.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory])
  end
end
