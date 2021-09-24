class PagesController < ApplicationController
  def index
     @feedback = Feedback.new
    @company = Company.all.collect{|c| [c.name,c.id.to_s]}
    # @company = company.map{|c| [c[0],c[1].to_s]}
    # @cracker = Cracker.all.pluck(:name)
  end

  def feedback
  end
  def feeds
    @feeds = Feedback.includes([:company, :cracker]).all
  end
  def feed_update
    @feed = Feedback.new(feed_params)
    @feed.company_id = Company.where(id: feed_params[:company]).first.id
    @feed.cracker_id = Cracker.where(id: feed_params[:cracker]).first.id
    if @feed.save
      redirect_to root_path,  :flash => { :success => "Feedback Posted Successfully" }
    else
      redirect_to root_path, flash: {error: @feed.errors}
    end
  end
  def crck_fetch
    @company = Company.where(id: params[:company]).first
    cracker = Cracker.where(company_id: @company[:id]).all.pluck(:code,:name,:id)
    @cracker = []
    cracker.each do |c|
      @cracker << [c[0]+" - "+c[1],c[2]]
    end
    # raise @cracker.inspect
    respond_to do |format|
      format.json { render json: @cracker }
    end
  end

  def order
    @companies = Company.all
    @crackers = Cracker.all
    @order = Order.new
  end
  
  def order_show
    @order = Order.all
  end

  private

    def feed_params
      params.require(:feedback).permit(:name, :phone_number, :company, :cracker, :description)
    end

    
end
