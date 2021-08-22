class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @tags = Tag.all.pluck(:name,:id)
  end

  def create

    @category = Category.new(name: category_params[:name])
    
    category_params[:tags].each do |tag|
      @tag = Tag.where(id: tag).first
      if !(@tag.nil?)
      @category.tag_ids << @tag.id
      end
    end
    if @category.save
      redirect_to root_path
    else
      redirect_to action: :new
    end
  end

  def edit
    @category = Category.find(params[:id])

    @selected = @category.tag_ids
    @select = []
    @selected.each do |s|
      # tag = Tag.where(id: s).first
      @select << s.to_s
    end
    @tags = Tag.all.pluck(:name,:id)
  end

  def update
    # raise params.inspect
    @category = Category.where(id: update_params[:id].to_s).first
    @category.name = update_params[:name]
    tag_ids =[]
    update_params[:tags].each do |tag|
      if !(tag == "" && @category.tag_ids.include?(tag.to_s))
        @tag = Tag.where(id: tag.to_s).first
        if !@tag.nil?
          tag_ids << @tag.id
        end
      end
    end
    @category.tag_ids = tag_ids
    # raise @category.inspect
    if @category.save
      redirect_to tag_show_path(@category)
    else
      redirect_to action: :new
    end
  end
  
  def destroy
    # raise params.inspect
    @cat = Category.where(id: params[:id]).first
    if @cat.destroy
      redirect_to root_path
    else
      redirect_to tag_show_path(@cat)
    end
  end
  private

  def category_params
    params.require(:category).permit(:name,tags: [])
  end

  def update_params
    params.require(:category).permit(:id,:name,tags: [])
  end
end
