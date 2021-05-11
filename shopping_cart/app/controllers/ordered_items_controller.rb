class OrderedItemsController < ApplicationController
  before_action :authenticate_user!
  def show
    @ordered_item = OrderedItem.find_by id: params[:id]
  end
end
