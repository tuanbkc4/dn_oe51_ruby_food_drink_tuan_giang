class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: %i(update edit)
  before_action :check_order, only: %i(edit)

  def index
    @pagy, @orders = pagy(Order.all_order_desc, items: Settings.c_item.c_6)
  end

  def edit; end

  def update
    if check_update
      flash[:danger] = t "admin.orders.index.update_fail"
    else
      @order.update(status: status_params[:status].to_i)
      flash[:success] = t "admin.orders.index.update_success"
    end
    redirect_to admin_orders_path
  end

  private

  def status_params
    params.require(:order).permit(:status)
  end

  def load_order
    @order = Order.find_by(id: params[:id])
    return if @order

    flash[:danger] = t "orders.index.not_find"
    redirect_to admin_orders_path
  end

  def check_order
    return unless @order.completed? || @order.cancelled?

    flash[:danger] = t "admin.orders.index.check_order"
    redirect_to admin_orders_path
  end

  def gap change_status, current_status
    (change_status.to_i - current_status).abs
  end

  def check_update
    return true if status_params[:status].to_i <
                   Order.statuses[@order.status] ||
                   gap(status_params[:status].to_i,
                       Order.statuses[@order.status]) > 1
  end
end
