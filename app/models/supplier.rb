class Supplier < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  belongs_to :customer
  has_one :car
end
