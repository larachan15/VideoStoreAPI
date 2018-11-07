class Customer < ApplicationRecord
  has_many :movies

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true, length: {is: 5}, :format => { with: /[0-9]+/ }
    # :TODO make it 5 digit
  validates :phone, presence: true, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }
  validates :movies_checked_out_count, presence: true, numericality: {greater_than_equal_to: 0}
end
