class Booking < ApplicationRecord
  belongs_to :user
  has_one :customer
  has_one :supplier
  has_one :car 
end
