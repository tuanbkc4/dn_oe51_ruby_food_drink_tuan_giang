class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: %i(index new create)

  def index
    @pagy, @categories = pagy(Category.all, items: Settings.c_item.c_6)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = t ".update_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def edit; end

  def destroy
    if @category.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(Category::CATEGORY_ATTR)
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t ".find_fail"
    redirect_to admin_categories_path
  end
end
