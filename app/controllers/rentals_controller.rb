class RentalsController < ApplicationController
  def checkin
    if params[:customer_id]
      customer = Customer.find_by(id: params[:customer_id])
      movie = Movie.find_by(id: params[:movie_id])
      rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])

      checkin_date = Time.now
      # binding.pry
      checkout_date = rental.checkout_date

      rental = Rental.new(customer_id: customer.id, movie_id: movie.id, checkin_date: checkin_date, checkout_date: checkout_date)

      if rental.save
        render json: { customer_id: customer.id, movie_id: movie.id }, status: :ok
      else
        render_error(:bad_request, rental.errors.messages)
      end
    end
  end

  def checkout
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])

    if customer && movie && movie.is_available?
# binding.pry
      checkout_date = Time.now
      checkin_date = Date.today(checkout_date) + 7

      rental = Rental.new(customer_id: customer.id, movie_id: movie.id, checkin_date: checkin_date, checkout_date: checkout_date)

      if rental.save
        movie.decrement_inventory!
        # binding.pry
        render json: {
          customer_id: customer.id,
          movie_id: movie.id,
          available_inventory: movie.available_inventory,
          rental_id: rental.id
        }, status: :ok
      else
        render_error(:bad_request, rental.errors.messages)
      end
    else
      render_error(:bad_request, "Invalid parameters")
    end
  end
end
