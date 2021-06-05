class Car < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  belongs_to :customer
  belongs_to :supplier 
end
