class ApplicationController < ActionController::Base
	include PublicActivity::StoreController

	protect_from_forgery
	include SessionsHelper
	helper_method :current_user
	hide_action :curent_user

	# Force signout to prevent CSRF attacks
	def handle_unverified_request
		sign_out
		super
	end
end