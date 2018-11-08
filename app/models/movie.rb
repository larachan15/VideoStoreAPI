class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: {greater_than_equal_to: 0, only_integer: true}

  # validates :available_inventory, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}

  # use ? for when you are returning a boolean
  def is_available?
    return self.available_inventory > 0
  end

  # use ! for when you are modifying the model
  def decrement_inventory!
    self.available_inventory = self.available_inventory - 1
    self.save
  end
end
