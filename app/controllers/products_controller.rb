class ProductsController < ApplicationController
   def new
    @product = Product.new
    @tags = Tag.all.pluck(:name,:id)
  end

  def create

    @product = Product.new(name: product_params[:name])
    @product.price = product_params[:price]
    @product.details = product_params[:details]
    @product.description = product_params[:description]
    @product.stock = product_params[:stock]
    product_params[:tags].each do |tag|
      @tag = Tag.where(id: tag).first
      if !(@tag.nil?)
      @product.tag_ids << @tag.id
      end
    end
    if @product.save
      redirect_to root_path
    else
      redirect_to action: :new
    end
  end

  def edit
    @product = Product.find(params[:id])

    @selected = @product.tag_ids
    @select = []
    @selected.each do |s|
      # tag = Tag.where(id: s).first
      @select << s.to_s
    end
    @tags = Tag.all.pluck(:name,:id)
  end

  def update
    # raise params.inspect
    @product = Product.where(id: update_params[:id].to_s).first
    @product.name = update_params[:name]
    tag_ids =[]
    @product.price = update_params[:price]
    @product.details = update_params[:details]
    @product.description = update_params[:description]
    @product.stock = update_params[:stock]
    update_params[:tags].each do |tag|
      if !(tag == "" && @product.tag_ids.include?(tag.to_s))
        @tag = Tag.where(id: tag.to_s).first
        if !@tag.nil?
          tag_ids << @tag.id
        end
      end
    end
    @product.tag_ids = tag_ids
    # raise @product.inspect
    if @product.save
      redirect_to details_show_path(@product)
    else
      redirect_to action: :new
    end
  end
  
  def destroy
    # raise params.inspect
    @prod = Product.where(id: params[:id]).first
    if @prod.destroy
      redirect_to root_path
    else
      redirect_to prod_show_path(@prod)
    end
  end
  private

  def product_params
    params.require(:product).permit(:name,:price,:stock,:details,:description,tags: [])
  end

  def update_params
    params.require(:product).permit(:id,:name,:price,:stock,:details,:description,tags: [])
  end
end
