require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
    if signed_in?
        if params[:tag]
          @micropost = current_user.microposts.build 
          @feed_items = Micropost.tagged_with(params[:tag]).paginate(page: params[:page]).per_page(15)
        else
        	@micropost = current_user.microposts.build 
        	@feed_items = current_user.feed.paginate(page: params[:page]).per_page(15)
        end
    end
  end

  def help
  end

  def about
  end

  def contact
  end

	def trending
		if signed_in?
			@trending_items = Micropost.paginate(page: params[:page]).per_page(15)
		end
	end
  
end
