class StaticPagesController < ApplicationController
 def home
    if logged_in?
      @image  = current_user.images.build
      @feed_items = current_user.feed.paginate(page: params[:page]).search(params[:search])
    end
  end

  def help
  end
  
  def about
  end
end
