class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.length.l_255},
    uniqueness: true

  validates :parent, numericality: {only_integer: true}
end
