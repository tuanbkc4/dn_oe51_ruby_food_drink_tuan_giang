class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by user_name: params[:session][:user_name]
    if user&.authenticate params[:session][:password]
      active user
    else
      flash.now[:danger] = t "login.fails"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def active user
    log_in user
    if user.role == "admin"
      flash[:success] = t "login.admin_success"
      redirect_back_or admin_root_url
    else
      flash[:success] = t "login.success"
      redirect_back_or root_url
    end
  end
end
