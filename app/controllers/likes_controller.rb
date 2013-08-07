class LikesController < ApplicationController
	before_filter :signed_in_user

	def create
		@like = Like.new(params[:like])
		session[:return_to] = request.referer
		if @like.save
			if params[:like][:comment_id].nil?
				redirect_to session[:return_to]
			else
				redirect_to session[:return_to]
			end
		else
			@feed_items = []
			redirect_to session[:return_to]
		end
	end

	def destroy

	end

end
