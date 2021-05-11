class ShippingDetail < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validates :pin_code, presence: true, length: { is: 6 }
  validates :city, presence: true
  validates :state, presence: true
  validates :mobile_number, presence: true, length: { is: 10 }
end
