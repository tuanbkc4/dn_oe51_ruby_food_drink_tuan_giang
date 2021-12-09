class Admin::BaseController < ApplicationController
  layout "admin/layouts/base"
  include Admin::CategoriesHelper
  before_action :logged_admin?

  def logged_admin?
    return if admin_logged_in?

    redirect_to root_url
    flash[:danger] = t "login.not_allowed"
  end
end
