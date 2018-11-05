class Customer < ApplicationRecord
  has_many :movies

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
    # :TODO make it 5 digit
  validates :phone, presence: true
end
