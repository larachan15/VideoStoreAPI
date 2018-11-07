class Movie < ApplicationRecord
  has_many :customers

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: {greater_than_equal_to: 0, only_integer: true}
end
