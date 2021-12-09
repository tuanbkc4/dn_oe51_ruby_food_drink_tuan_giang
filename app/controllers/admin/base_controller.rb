class Admin::BaseController < ApplicationController
  layout "admin/layouts/base"
  include Admin::CategoriesHelper
end
