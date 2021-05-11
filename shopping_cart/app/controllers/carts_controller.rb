class CartsController < ApplicationController
  before_action :authenticate_user!, except: [:view]
  def view
    if user_signed_in?
      merge_session_cart
    end
  end

  def merge_session_cart
    if session[:items] 
      session[:items].each do |item_id,item| 
        product_details = item[I18n.t('models.attributes.product_details')] 
        if !(current_user.cart_items.find_by product_id: product_details[I18n.t('models.attributes.id')]) 
          cart_item = current_user.cart_items.new 
          cart_item.description = product_details[I18n.t('models.attributes.description')] 
          cart_item.price = product_details[I18n.t('models.attributes.price')] 
          cart_item.file = product_details[I18n.t('models.attributes.file')][I18n.t('models.attributes.url')] 
          cart_item.return_or_replacement_applicable_days = product_details[I18n.t('models.attributes.return_replacement')] 
          cart_item.seller_name = product_details[I18n.t('models.attributes.seller_name')] 
          cart_item.product_id = product_details[I18n.t('models.attributes.id')] 
          cart_item.available_quantity = product_details[I18n.t('models.attributes.available_quantity')] 
          cart_item.quantity = item[I18n.t('models.attributes.quantity')] 
          cart_item.save! 
        end
      end
      session[:items] = nil
    end
  end

  def clear 
    current_user.cart_items.destroy_all
  end

end