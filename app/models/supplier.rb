class Supplier < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  belongs_to :customer 
end
