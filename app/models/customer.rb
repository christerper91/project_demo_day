class Customer < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  has_one_attached :customer_ic
  has_one_attached :customer_license
end
