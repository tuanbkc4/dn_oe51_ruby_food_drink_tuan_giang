class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  CATEGORY_ATTR = %w(name parent_id).freeze

  validates :name, presence: true,
    length: {maximum: Settings.length.l_255},
    uniqueness: true

  scope :root_categories, ->{where("parent_id IS NULL")}
end
