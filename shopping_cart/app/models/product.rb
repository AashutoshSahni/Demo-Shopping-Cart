class Product < ApplicationRecord
  belongs_to :user
  mount_uploader :file, FileUploader
  
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true, numericality: { only_float: true }
  validates :available_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :file, presence: true
end
