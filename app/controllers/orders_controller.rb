class OrdersController < ApplicationController
  def crack_show
    @crack = Cracker.where(company_id: params[:company_id]).all
    respond_to do |format|
      format.json {render json: @crack}
    end
    
  end

  def order_update
    
    order = Order.new(order_params)
    if order.save
      respond_to do |format|
        format.json {render json: order}
      end
      
    else
      

    end
  end


  private

    def order_params
      params.permit(:name,:phone,:address,:cart => {})
    end
end
