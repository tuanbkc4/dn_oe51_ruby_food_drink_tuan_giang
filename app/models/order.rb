class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  belongs_to :user
  belongs_to :address, optional: true
  before_save :init_status

  ORDER_ATTR = %w(address_id status).freeze

  enum status: {
    open: 0,
    pending: 1,
    confirmed: 2,
    shipping: 3,
    completed: 4,
    cancelled: 5
  }
  scope :all_order_desc, ->{Order.not_open.order(created_at: :desc)}

  private

  def init_status
    self.status ||= 0
  end
end
