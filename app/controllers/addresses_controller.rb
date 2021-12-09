class AddressesController < ApplicationController
  before_action :current_address, only: %i(edit destroy update)
  before_action :check_order, only: :destroy

  def new
    @address = Address.new
  end

  def edit; end

  def create
    @address = current_user.addresses.build(add_params)
    ActiveRecord::Base.transaction do
      set_add_default add_params["is_default"]
      @address.save!
    end

    flash[:success] = t ".create_success"
    redirect_to user_path(current_user)
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".create_fail"
    render :new
  end

  def update
    ActiveRecord::Base.transaction do
      set_add_default add_params["is_default"]
      @address.update! add_params
    end

    flash[:success] = t ".update_success"
    redirect_to user_path(current_user)
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".update_fail"
    render :edit
  end

  def destroy
    if @address.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to user_path(current_user)
  end

  private
  def add_params
    params.require(:address).permit(Address::ADD_ATTRS)
  end

  def current_address
    @address = Address.find_by id: params[:id]
    return if @address

    flash[:danger] = t "users.show.not_found_add"
    redirect_to user_path(current_user)
  end

  def check_order
    return if @address.orders.blank?

    flash[:danger] = t ".delete_fail"
    redirect_to user_path(current_user)
  end
end
