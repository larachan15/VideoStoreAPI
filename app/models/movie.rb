class Movie < ApplicationRecord
  has_many :customers

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
<<<<<<< HEAD
  validates :inventory, presence: true, numericality: {greater_than_equal_to: 0, only_integer: true}
=======
  validates :inventory, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :available_inventory, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
>>>>>>> fecf9952f581f0cf37ebc96a9ef6c5f6a722fc75
end
