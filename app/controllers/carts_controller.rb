class CartsController < ApplicationController
  before_action :find_product, except: :index
  before_action :find_item, except: %i(index create)
  before_action :get_items_cart, only: :index

  def index; end

  def create
    item = find_product_in_cart @product
    if item
      item["quantity"] += params[:quantity].to_i
      flash[:success] = t "carts.index.update"
    else
      current_cart << {
        product_id: @product.id,
        quantity: params[:quantity].to_i
      }
      flash[:success] = t "carts.index.add"
    end
    session[:cart] = current_cart
    redirect_to carts_path
  end

  def update_cart
    @item["quantity"] = params[:quantity].to_i
    flash[:success] = t "carts.index.update_qty"
    redirect_to carts_path
  end

  def destroy
    current_cart.delete @item
    flash[:success] = t "carts.index.remove"
    redirect_to carts_path
  end

  private

  def find_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t "product.not_found"
    redirect_to root_path
  end

  def find_item
    @item = find_product_in_cart @product
    return if @item

    flash[:danger] = t "carts.index.not_found"
    redirect_to root_path
  end

  def get_items_cart
    @carts = get_all_item_in_cart
    return if @carts.present?

    flash[:warning] = t "carts.index.empty"
  end
end
