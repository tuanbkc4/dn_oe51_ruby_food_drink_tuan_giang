class Address < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  ADD_ATTRS = %w(address is_default phone).freeze

  validates :phone, presence: true,
    length: {is: Settings.length.l_10},
    numericality: {only_integer: true}

  def address_initial
    "#{address} - #{phone}"
  end
end
