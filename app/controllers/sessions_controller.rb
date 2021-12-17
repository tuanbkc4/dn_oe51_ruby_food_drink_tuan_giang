class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by user_name: params[:session][:user_name]
    if user&.authenticate params[:session][:password]
      flash[:success] = t "login.success"
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = t "login.fails"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
