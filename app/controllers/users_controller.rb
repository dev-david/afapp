class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :show, :destroy, :following, :followers]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user,     only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			@user.create_activity :create, owner: @user
			sign_in @user
			flash[:success] = "Welcome to Asia Fan " + @user.user_name + "! Post something on the left or find a trend or user to follow!"
			redirect_to trending_url
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated for " + @user.user_name + "!"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
	    User.find(params[:id]).destroy
	    flash[:success] = "User destroyed."
	    redirect_to users_url
	end

	def following
	    @title = "Following"
	    @user = User.find(params[:id])
	    @users = @user.followed_users.paginate(page: params[:page])
	    render 'show_follow'
	  end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	private

 #    def signed_in_user
	# 	unless signed_in?
	# 		store_location
	# 		flash[:notice] = "Please sign in."
	# 		redirect_to signin_url
	# 	end
	# end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
    end

	def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end