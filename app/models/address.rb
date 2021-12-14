class Address < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :user, presence: true,
    numericality: {only_integer: true}

  validates :address, :is_default, presence: true

  validates :phone, presence: true,
    length: {is: Settings.length.l_10},
    numericality: {only_integer: true}
end
