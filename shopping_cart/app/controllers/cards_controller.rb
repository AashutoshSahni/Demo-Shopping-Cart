class CardsController < ApplicationController
  before_action :authenticate_user!
  def index
    session[:shipping_details_id] = params[:shipping_details_id]
  end

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params)
    redirect_to cards_path and return if @card.save
    render :new
  end

  def edit
    @card = current_user.cards.find_by id: params[:id]
  end

  def update
    @card = current_user.cards.find_by id: params[:id]
    redirect_to cards_path and return if @card.update(card_params)
    render :new
  end
  
  def destroy
    @card = current_user.cards.find_by id: params[:id]
    @card.destroy
  end

  private
    def card_params
      params.require(:card).permit(:card_owner, :card_number, :cvv, :expiry_date, :shipping_details_id)
    end
end
