class LinksController < ApplicationController
  def show
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      @result = @link
      @link = Link.new
    end

    render 'show'
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
