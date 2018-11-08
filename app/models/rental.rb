class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :checkout_date, presence: true

  def self.get_rental(customer_id, movie_id)
    return Rental.where(movie_id: movie_id, customer_id: customer_id, checkin_date: nil).order(due_date: :asc).first
  end
end
