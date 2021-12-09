class Admin::ProductsController < Admin::BaseController
  before_action :load_product, except: %i(index new create)

  def index
    @pagy, @products = pagy(Product.all_product_sort_desc,
                            items: Settings.c_item.c_6)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_success"
      redirect_to admin_products_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = t ".update_success"
      redirect_to admin_products_path
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def edit; end

  def destroy; end

  private

  def product_params
    params.require(:product).permit(Product::PRODUCT_ATTR)
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t ".find_fail"
    redirect_to admin_products_path
  end
end
