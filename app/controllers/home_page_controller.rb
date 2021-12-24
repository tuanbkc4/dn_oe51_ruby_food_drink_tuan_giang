class HomePageController < ApplicationController
  def index
    @pagy, @products = pagy(
      Product.latest_product,
      items: Settings.c_item.c_6
    )
  end
end
