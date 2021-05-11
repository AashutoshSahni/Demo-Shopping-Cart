class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :recoverable, :rememberable, 
         :validatable, :confirmable, :database_authenticatable
  has_many :products, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :shipping_details, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, presence: true
  validate :validate_email
  validates :email, uniqueness: true
  
  def validate_email
    return if email.match?(/\A[\w!#$%&'*+-=?^_`{|}~]+@\w+\.\w+\Z/)
    errors.add(:email, I18n.t('errors.not_valid')) 
  end  

end
