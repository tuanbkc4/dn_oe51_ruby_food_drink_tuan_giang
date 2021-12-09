module CartsHelper
  def current_cart
    session[:cart] ||= Array.new
  end

  def get_all_item_in_cart
    cart_items = []
    current_cart.each do |item|
      product = Product.find_by(id: item["product_id"])
      if product
        cart_items << {
          product: product,
          quantity: item["quantity"]
        }
      else
        current_cart.delete(item)
      end
    end
    cart_items
  end

  def find_product_in_cart product
    current_cart.find{|item| item["product_id"] == product.id}
  end

  def total_price item
    item[:product].price * item[:quantity].to_i
  end

  def total_all_price
    items = get_all_item_in_cart
    items.reduce(0) do |total, item|
      total + item[:product].price * item[:quantity].to_i
    end
  end
end
