class Product < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  belongs_to :category
  after_initialize :init

  validates :name, presence: true,
    length: {maximum: Settings.length.l_255}

  validates :price, presence: true,
    numericality: {only_decimal: true}

  validates :detail, presence: true

  scope :latest_product, ->{order(created_at: :desc).limit(Settings.c_item.c_6)}

  private

  def init
    self.rating ||= 1
  end
end
