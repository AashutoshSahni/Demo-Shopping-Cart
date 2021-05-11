class ShippingDetailsController < ApplicationController
  before_action :authenticate_user!
  def index

  end

  def new
    @shipping_detail = current_user.shipping_details.new
  end

  def create
    @shipping_detail = current_user.shipping_details.new(shipping_detail_params)
    redirect_to shipping_details_path and return if @shipping_detail.save
    render :new
  end

  def edit
    @shipping_detail = current_user.shipping_details.find_by id: params[:id]
  end

  def update
    @shipping_detail = current_user.shipping_details.find_by id: params[:id]
    redirect_to "index" and return if @shipping_detail.update(shipping_detail_params)
    render :new
  end
  
  def destroy
    @shipping_detail = current_user.shipping_details.find_by id: params[:id]
    @shipping_detail.destroy
  end

  private
    def shipping_detail_params
      params.require(:shipping_detail).permit(:name, :address, :pin_code, :city, :state, :mobile_number)
    end
end
