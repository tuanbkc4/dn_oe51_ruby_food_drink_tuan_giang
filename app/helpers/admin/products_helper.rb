module Admin::ProductsHelper
  def check_image_tag product
    product.image.attached?
  end
end
