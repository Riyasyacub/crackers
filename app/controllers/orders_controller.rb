class OrdersController < ApplicationController
  def crack_show
    @crack = Cracker.where(company_id: params[:company_id]).all
    respond_to do |format|
      format.json {render json: @crack}
    end
  end
end
