class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']
        session[:omniauth] = auth.except('extra')
        user = User.sign_in_from_omniauth(auth)
        
        session[:user_id] = user.id unless auth["credentials"].blank?
        redirect_to root_url, notice: "SIGNED IN"
        
        #other article
        # user = User.find_by(twitter_handle: auth[:info][:nickname])
        # user ||= User.create!(
        # full_name: auth[:info][:name],
        # twitter_handle: auth[:info][:nickname],
        # location: auth[:info][:location]
        # )
        # session[:user_id] = user.id
        # redirect_to movie_path
        
    end
    def destroy
        session[:user_id] = nil
        session[:omniauth] = nil
        redirect_to root_url, notice:"SIGNED OUT"
    end 
end
 # auth_hash = request.env['omniauth.auth']
        # user = User.find_by(twitter_handle: auth_hash[:info][:nickname])
        # user ||= User.create!(
        # full_name: auth_hash[:info][:name],
        # twitter_handle: auth_hash[:info][:nickname],
        # location: auth_hash[:info][:location]
        # )
        # session[:user_id] = user.id
        # redirect_to dashboard_path