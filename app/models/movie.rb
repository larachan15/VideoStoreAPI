class Movie < ApplicationRecord
  has_many :rentals

  before_create :calibrate_inventory

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: {greater_than_equal_to: 0, only_integer: true}

  # validates :available_inventory, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}

  private
  # https://stackoverflow.com/questions/6720597/rails-validate-product-ordered-has-the-available-quantity?rq=1
  def calibrate_inventory
    self.available_inventory = self.inventory
  end
end
