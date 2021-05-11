class CartItemsController < ApplicationController
  skip_before_action :authenticate_user!
  def add
    id = params[:id]
    product = Product.find_by id: id 
    if user_signed_in? and !current_user.cart_items.find_by product_id: params[:id] 
      cart_item = current_user.cart_items.new 
      cart_item.description = product.description 
      cart_item.price = product.price 
      cart_item.file = product.file 
      cart_item.return_or_replacement_applicable_days = product.return_or_replacement_applicable_days 
      cart_item.seller_name = product.seller_name 
      cart_item.product_id = product.id 
      cart_item.quantity = 1
      cart_item.available_quantity = product.available_quantity 
      cart_item.save! 
    else 
      if session[:items].nil? 
        session[:items] = {product.id => {I18n.t('models.attributes.product_details') => product}} 
        puts "session #{session[:items][product.id]}" 
        session[:items][product.id][I18n.t('models.attributes.quantity')] = 1 
      elsif session[:items][product.id].nil?
        puts " after_add#{session[:items]}" 
        session[:items][product.id] =  {I18n.t('models.attributes.product_details') => product} 
        session[:items][product.id][I18n.t('models.attributes.quantity')] = 1 
      end
    end 
  end

  def increment
    @updated = false
    if user_signed_in?
      cart_item = current_user.cart_items.find_by id: params[:id]
      if cart_item.quantity < cart_item.available_quantity
        @updated = true
        cart_item.quantity += 1
        cart_item.save
        @updated_quantity = cart_item.quantity
        session[:total_amount] += cart_item.price
      end
    elsif session[:items] and session[:items][params[:id]][I18n.t('models.attributes.quantity')] < session[:items][params[:id]]['product_details']['available_quantity'] 
      @updated = true;
      session[:items][params[:id]][I18n.t('models.attributes.quantity')] += 1 
      @updated_quantity = session[:items][params[:id]][I18n.t('models.attributes.quantity')]
      session[:total_amount] += session[:items][params[:id]][I18n.t('models.attributes.product_details')][I18n.t('models.attributes.price')] 
    end 
  end

  def decrement
    @updated = false
    if user_signed_in?
      cart_item = current_user.cart_items.find_by id: params[:id]
      if cart_item.quantity > 1
        @updated = true
        cart_item.quantity -= 1
        cart_item.save
        @updated_quantity = cart_item.quantity
        session[:total_amount] -= cart_item.price
      end
    elsif session[:items] and session[:items][params[:id]][I18n.t('models.attributes.quantity')] > 1 
      @updated = true;
      session[:items][params[:id]][I18n.t('models.attributes.quantity')] -= 1 
      @updated_quantity = session[:items][params[:id]][I18n.t('models.attributes.quantity')]
      session[:total_amount] -= session[:items][params[:id]][I18n.t('models.attributes.product_details')][I18n.t('models.attributes.price')] 
    end  
  end

  def destroy
    if user_signed_in?
      cart_item = current_user.cart_items.find_by id: params[:id]
      session[:total_amount] -= (cart_item.price * cart_item.quantity)
      cart_item.destroy
      cart_item.save
    else
      session[:total_amount] -= (session[:items][params[:id]][I18n.t('models.attributes.product_details')][I18n.t('models.attributes.price')] * session[:items][params[:id]][I18n.t('models.attributes.quantity')]) 
      session[:items].delete(params[:id]) 
    end
  end

end
