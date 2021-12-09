class Product < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  belongs_to :category
  has_one_attached :image
  after_initialize :init

  PRODUCT_ATTR = %w(category_id name detail image price rating).freeze

  validates :name, presence: true,
    length: {maximum: Settings.length.l_255}

  validates :price, presence: true,
    numericality: {only_decimal: true}

  validates :detail, :category, presence: true

  scope :latest_product, ->{order(created_at: :desc).limit(Settings.c_item.c_6)}
  scope :all_product_sort_desc, ->{order(created_at: :desc)}

  private

  def init
    self.rating ||= 1
  end
end
