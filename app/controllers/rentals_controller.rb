class RentalsController < ApplicationController
  def checkin
    rental = Rental.get_rental(params[:customer_id], params[:movie_id])

    if rental
      rental.checkin_date = Time.now
      # binding.pry
      if rental.save
        rental.movie.increment_inventory!
        rental.customer.decrement_movies_checked_out_count!
        render json: { rental_id: rental.id, customer_id: rental.customer.id, movie_id: rental.movie.id }, status: :ok
      else
        render_error(:bad_request, rental.errors.messages)
      end
    else
      render_error(:bad_request, "Invalid parameters")
    end
  end

  def checkout
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])

    if customer && movie && movie.is_available?
# binding.pry
      checkout_date = Time.now
      due_date = Date.today(checkout_date) + 7

      rental = Rental.new(customer_id: customer.id, movie_id: movie.id, due_date: due_date, checkout_date: checkout_date)

      if rental.save
        movie.decrement_inventory!
        customer.increment_movies_checked_out_count!
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
