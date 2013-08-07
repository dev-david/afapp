class CommentsController < ApplicationController
	before_filter :signed_in_user, :only => [:create, :destroy]
	before_filter :correct_user, :only => :destroy

	def create
		# render :text => params[:comment]
	    @comment = Comment.new(params[:comment])
	    session[:return_to] = request.referer
		if @comment.save
			flash[:success] = "Your comment has been posted!"
			redirect_to session[:return_to]
		else
			@feed_items = []
			flash[:error] = "There was a problem with your comment!"
			redirect_to session[:return_to]
		end
	end

	def destroy
	    session[:return_to] = request.referer
		@comment.destroy
		flash[:success] = "Comment has been deleted!"
		redirect_to session[:return_to]	    
	end

	private

    def correct_user
    	if !current_user.admin?
			@comment = current_user.comments.find_by_id(params[:id])
			redirect_to root_url if @comment.nil? 
		else
			@comment = Comment.find_by_id(params[:id])
			redirect_to root_url if @comment.nil? 
		end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end