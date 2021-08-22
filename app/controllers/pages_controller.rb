class PagesController < ApplicationController
  def index
    @cat = Category.all
  end

  def tag_show
    @cat = params[:id]
    @tags = Category.where(id: params[:id]).first.tags.all
  end

  def prod_show
    @products = Tag.where(id: params[:id]).first.products.all
  end

  def details_show
    @details = Product.where(id: params[:id]).first
  end
end
