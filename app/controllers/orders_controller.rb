class OrdersController < ApplicationController
  before_action :check_user, :check_address
  before_action :check_order, only: %i(index update)
  before_action :load_order, only: :cancel

  def index
    store_location
  end

  def show
    @orders = @user.orders.all_order_desc
  end

  def create
    ActiveRecord::Base.transaction do
      create_order
      redirect_to orders_path
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "orders.index.err"
    redirect_to carts_path
  end

  def update
    ActiveRecord::Base.transaction do
      @order.update order_params
      session.delete :cart
      flash[:success] = t "orders.index.success"
      redirect_to order_path(@user)
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".err"
    redirect_to orders_path
  end

  def cancel
    if @order.status == "pending"
      @order.update(status: "cancelled")
      flash[:success] = t "orders.list_order.cancel_success"
    else
      flash[:danger] = t "orders.list_order.cancel_fail"
    end
    redirect_to order_path(@user)
  end

  private

  def load_order
    @order = current_user.orders.find_by(id: params[:id])
    return if @order

    flash[:danger] = t "orders.index.not_find"
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit(Order::ORDER_ATTR)
  end

  def create_order_detail
    @carts = get_all_item_in_cart
    @carts.each do |item|
      @order.order_details.build(
        product_id: item[:product].id,
        quantity: item[:quantity]
      )
    end
  end

  def create_order
    @order = current_user.orders.build(total_price: total_all_price.to_i)
    create_order_detail
    @order.save!
  end

  def check_order
    @order = @user.orders.find_by(status: :open)
    if @order.nil?
      flash[:danger] = t "orders.index.not_find"
      redirect_to root_path
    else
      @products = @order.order_details
    end
  end

  def check_user
    @user = current_user
    return if @user

    session[:forwarding_url] = carts_url

    redirect_to login_path
  end

  def check_address
    @address = @user.addresses
    return if @address.present?

    flash[:danger] = t "orders.index.add_address"
    session[:forwarding_url] = carts_url
    redirect_to new_address_path
  end
end
