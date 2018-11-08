class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true, length: {is: 5}, :format => { with: /[0-9]+/ }
  validates :phone, presence: true
  validates :movies_checked_out_count, presence: true, numericality: {greater_than_or_equal_to: 0}

  # format: { :with => /\d{3}-\d{3}-\d{4}/,
  # :message => "Phone number must be in xxx-xxx-xxxx format." }
  def increment_movies_checked_out_count!
    self.movies_checked_out_count = self.movies_checked_out_count + 1
    self.save
  end

  def decrement_movies_checked_out_count!
    self.movies_checked_out_count = self.movies_checked_out_count - 1
    self.save
  end
end
