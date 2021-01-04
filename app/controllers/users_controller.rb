class UsersController < ApplicationController

  #route to find a user's show page by slug
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/profile' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'users/profile_pic'
    end
  end

  post '/profile' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @user.image_url = params[:image_url]
      @user.save
      redirect "users/#{@user.slug}"
    end
  end

  get '/bio' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'users/bio'
    end
  end

  post '/bio' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @user.bio = params[:bio]
      @user.save
      redirect "users/#{@user.slug}"
    end
  end

end
