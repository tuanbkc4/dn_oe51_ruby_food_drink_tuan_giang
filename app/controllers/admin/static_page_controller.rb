class Admin::StaticPageController < Admin::BaseController
  def home
    @lastest_product = Product.latest_product
    @count_category = Category.count
    @count_product = Product.count
    @count_user = User.count
    @count_order = Order.count
  end
end
