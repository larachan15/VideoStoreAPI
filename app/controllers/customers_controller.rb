require 'date'

class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: jsonify(customers), status: :ok #response code
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: jsonify(customer), status: :ok #response code
    else
      # options
      # head :not_found
      # render json: {}, status: :not_found
      render_error(:not_found, { customer_id: ["No such customer"] } )
    end
  end

  def create
    customer = Customer.new(customer_params)
    # binding.pry
    if customer.save
      render json: { id: customer.id }, status: :ok
    else
      render_error(:bad_request, customer.errors.messages)
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count)
  end

  def jsonify(customer_data)
    return customer_data.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out_count])
  end
end
