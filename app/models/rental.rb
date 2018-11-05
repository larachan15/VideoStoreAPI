class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :checkin_date, presence: true
  validates :checkout_date, presence: true
end
