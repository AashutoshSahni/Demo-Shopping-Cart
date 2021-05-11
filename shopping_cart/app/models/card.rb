class Card < ApplicationRecord
  belongs_to :user
  validates :card_owner, presence: true
  validates :card_number, presence: true, length: { is:16 }
  validates :cvv, presence: true, length: { is: 3 }
  validates :expiry_date, presence: true
  validate :is_valid_card_number
  validate :is_valid_cvv
  validate :is_valid_expiry_date

  def is_valid_card_number
    return if card_number.match?(/\A\d{16}\Z/)
    errors.add(:card_number, I18n.t('errors.not_valid'))
  end

  def is_valid_cvv
    return if cvv.match?(/\A\d{3}\Z/)
    errors.add(:cvv, I18n.t('errors.not_valid'))
  end
  
  def is_valid_expiry_date
    return if expiry_date.match?(/\A(0[5-9]|10|11|12)\/20[2-9][1-9]\Z/)
    errors.add(:expiry_date, I18n.t('errors.not_valid'))
  end

end
