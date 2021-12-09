class Admin::BaseController < ApplicationController
  layout "admin/layouts/base"
  include Admin::CategoriesHelper
  include Admin::ProductsHelper
  before_action :logged_admin?

  def logged_admin?
    return if admin_logged_in?

    store_location
    redirect_to root_url
    flash[:danger] = t "login.not_allowed"
  end
end
