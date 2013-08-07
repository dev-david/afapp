class MicropostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def index
		redirect_to root_url
	end

	def create
		@micropost = current_user.microposts.build(params[:micropost])
	    session[:return_to] = request.referer
		if @micropost.save
			flash[:success] = "Post created!"
			redirect_to session[:return_to]
		else
			@feed_items = []
			render 'static_pages/home'
			# redirect_to session[:return_to]
		end
	end

	def destroy
	    session[:return_to] = request.referer
		@micropost.destroy
		flash[:success] = "Post has been deleted!"
		redirect_to session[:return_to]	    
	end

	private

    def correct_user
    	if !current_user.admin?
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_url if @micropost.nil? 
		else
			@micropost = Micropost.find_by_id(params[:id])
			redirect_to root_url if @micropost.nil? 
		end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end