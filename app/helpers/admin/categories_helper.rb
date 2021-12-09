module Admin::CategoriesHelper
  def root_categories
    @root_categories = Category.root_categories.pluck :name, :id
  end

  def get_name_root_category id
    return @root_category = Category.find_by(id: id).name if id.present?
  end

  def page_index params_page, index, per_page = Settings.c_item.c_6
    params_page ||= 1
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end
end
