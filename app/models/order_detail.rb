class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order
  before_save :calcular_total_price

  def calcular_total_price
    self.total_price = quantity * product.price
  end
end
