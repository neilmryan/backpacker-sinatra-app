require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "extra_secret"
  end

  get "/" do
    #binding.pry
    if logged_in?
      redirect "users/#{current_user.slug}"
    else
      erb :home
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      User.find_by(id: session[:user_id])
    end

  end

  get "/signup" do
    erb :'users/create_user'
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "users/#{@user.slug}"
    end
  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'users/show'
    else
      redirect "/login"
    end
  end

  get '/logout' do
      session.clear
      redirect '/login'
  end

end
