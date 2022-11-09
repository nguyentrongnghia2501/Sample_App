# frozen_string_literal: true

# Service to download ftp files from the server
class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help; end

  def about; end
end
