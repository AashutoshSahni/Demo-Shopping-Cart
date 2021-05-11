class Order < ApplicationRecord
  belongs_to :user
  has_many :ordered_items, dependent: :destroy
end
