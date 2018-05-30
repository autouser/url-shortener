class ClicksController < ApplicationController
  def index
    @link = Link.find_by(token: params[:token].to_s.downcase)
    redirect_to @link.url if @link
  end
end
