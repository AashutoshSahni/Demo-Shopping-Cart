class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :category]
  def index
   @products = Product.all
  end
  
  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)
    redirect_to category_path(@product.category) and return if @product.save
    render :new
  end
  
  def show
    @product = current_user.products.find_by id: params[:id]
  end

  def edit
    @product = current_user.products.find_by id: params[:id]
  end

  def update
    @product = current_user.products.find_by id: params[:id]
    redirect_to product_path and return if @product.update(product_params)
    render :edit
  end

  def view_user_items
    @items = current_user.products.all
  end

  def category
    @category = params[:category]
    @category_products = Product.where(category: @category)
  end

  def destroy
    @product = current_user.products.find_by id: params[:id]
    @product.destroy
  end
  
  private
    def product_params
      params.require(:product).permit(:description, :price, :category, :return_or_replacement_applicable_days, :file, :available_quantity).merge(seller_name: current_user.name)
    end
end
