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
end
