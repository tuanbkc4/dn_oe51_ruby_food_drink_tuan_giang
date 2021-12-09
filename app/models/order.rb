class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  belongs_to :user
  belongs_to :address
  before_save :init_status

  enum status: {
    pending: 0,
    confirmed: 1,
    shipping: 2,
    completed: 3,
    cancelled: 4
  }

  private

  def init_status
    self.status ||= 0
  end
end
