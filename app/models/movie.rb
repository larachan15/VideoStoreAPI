class Movie < ApplicationRecord
  has_many :customers

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :available_inventory, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
end
