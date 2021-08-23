class TagsController < ApplicationController
  def new
    @tag = Tag.new(name: params[:name])
    # @tag.save
    respond_to do |format|
      if @tag.save
        # format.html { redirect_to @, notice: 'User was successfully created.' }
        # format.js
        format.json { render json: @tag }
      end
    end
  end
  def index
    @tags = Tag.all
  end
  def edit
    @tag = Tag.where(id: params[:id]).first
    @select = []
    @selected = @tag.category_ids
    @selected.each do |s|
      @select << s.to_s
    end
    @category = Category.all.pluck(:name,:id)
    @selected = @tag.product_ids
    @select_p = []
    @selected.each do |s|
      @select_p << s.to_s
    end
    @product = Product.all.pluck(:name,:id)
  end

  def update
    @tag = Tag.where(id: update_params[:id] ).first
    @tag.name = update_params[:name]
    cat_ids =[]
    update_params[:category].each do |tag|
      if !(tag == "" && @tag.category_ids.include?(tag.to_s))
        @cat = Category.where(id: tag.to_s).first
        if !@cat.nil?
          cat_ids << @cat.id
        end
      end
    end
    @tag.category_ids = cat_ids
    prod_ids =[]
    update_params[:product].each do |tag|
      if !(tag == "" && @tag.product_ids.include?(tag.to_s))
        @prod = Product.where(id: tag.to_s).first
        if !@prod.nil?
          prod_ids << @prod.id
        end
      end
    end
    @tag.product_ids = prod_ids
    # raise @category.inspect
    if @tag.save
      redirect_to tags_show_path(@tag)
    else
      redirect_to action: :edit
    end
  end
  def show
    @tag = Tag.where(id: params[:id]).first
  end
  def delete
    @tag = Tag.where(id: params[:id]).first
    if @tag.destroy
      redirect_to action: :index
    else
      redirect_to tags_show_path(@tag.id)
    end
  end
  private

  def update_params
    params.require(:tag).permit(:id,:name,category: [], product: [])
  end
end
