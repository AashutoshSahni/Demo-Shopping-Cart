class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.all
  end
  
  def show
    @order = current_user.orders.find_by id: params[:id]
  end

  def new
    @order = current.orders.new
  end

  def create
    @order = current_user.orders.new
    @order.order_amount = session[:total_amount]
    @order.shipping_charges = session[:shipping_charges]
    @order.total_amount_paid = session[:total_amount] + session[:shipping_charges]
    @order.order_date = Date.today
    @order.expected_delivery_date = Date.today + 4
    shipping_details = ShippingDetail.find_by id: session[:shipping_details_id].to_i
    @order.address = shipping_details.address
    @order.pin_code = shipping_details.pin_code
    @order.city = shipping_details.city
    @order.state = shipping_details.state
    card = Card.find_by id: params[:card_id].to_i
    @order.card_number = card.card_number
    if @order.save
      cart_items = current_user.cart_items.all
      cart_items.each do |cart_item|
        ordered_item = @order.ordered_items.new
        ordered_item.description = cart_item.description
        ordered_item.price_per_item = cart_item.price
        ordered_item.quantity = cart_item.quantity
        ordered_item.total_price = cart_item.price * cart_item.quantity
        ordered_item.file = cart_item.file
        ordered_item.seller_name = cart_item.seller_name
        ordered_item.return_or_replacement_applicable_days = cart_item.return_or_replacement_applicable_days
        ordered_item.user_id = current_user.id
        if ordered_item.save
          product = Product.find_by id: cart_item.product_id
          product.available_quantity -= cart_item.quantity
          product.save!
        end
      end
    end
    OrderMailer.delay_until(4.days.from_now).order_delivered(current_user.email, current_user.name)
    redirect_to orders_path
  end

  private
    def order_params
      params.require(:order).permit(:shipping_detail_id, :card_id)
    end
end
