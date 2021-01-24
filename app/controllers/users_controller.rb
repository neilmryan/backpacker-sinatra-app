class UsersController < ApplicationController

    #route to render create_user form
    get '/signup' do
      erb :'users/new'
    end

    #route to create a user using params validating no empty string data input
    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect '/signup'
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save == false
          flash[:message] = "Sorry, \nthat username is already in use."
          redirect '/signup'
        else
          @user.save
          session[:user_id] = @user.id
          redirect "users/#{@user.slug}"
        end
      end
    end

    #route to users index page, must be set above 'users/:slug' so the dynamic paramater doesn't confuse index for a slug
    get '/users/index' do
      @users = User.all
      erb :'users/index'
    end

    #route finds a user via slug methods in the User model to search via slug instead of user_id
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end

    #route gets profile img edit form
    get '/profile_img_edit' do
      if session[:user_id]
        @user = User.find(session[:user_id])
        erb :'users/profile_img_edit'
      end
    end

    #route posts profile img edit form and updates img
    post '/profile_img_edit' do
      if session[:user_id]
        @user = User.find(session[:user_id])
        @user.image_url = params[:image_url]
        @user.save
        redirect "users/#{@user.slug}"
      end
    end

    #route gets bio edit form
    get '/bio_edit' do
      if session[:user_id]
        @user = User.find(session[:user_id])
        erb :'users/bio_edit'
      end
    end

    #route posts bio edit form and updates bio
    post '/bio_edit' do
      if session[:user_id]
        @user = User.find(session[:user_id])
        @user.bio = params[:bio]
        @user.save
        redirect "users/#{@user.slug}"
      end
    end

    #route loads all packs created by the user
    get '/users/:slug/packs' do
      @user = User.find_by_slug(params[:slug])
      @packs = @user.packs
      erb :'users/packs'
    end

    #route loads a page to render a login form
    get '/login' do
      erb :'users/login'
    end

    #route logs in a user using posted data fom the login form and directs to the login page.
    post '/login' do
      @user = User.find_by(:email => params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :'users/show'
      else
        redirect "/login"
      end
    end

    #route logs out a user
    get '/logout' do
        session.clear
        redirect '/login'
    end

end
