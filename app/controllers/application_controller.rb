require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "extra_secret"
    register Sinatra::Flash
  end

  #home route brings a user to the login or create account page
  get "/" do
    #logged_in confirms user is logged in to redirect to user home page
    if logged_in?
      redirect "users/#{current_user.slug}"
    else
      erb :home
    end
  end

  #helper methods to check for user logged in and current user
  helpers do
    #uses double negation to return a boolean if the user is logged in
    def logged_in?
      !!current_user
    end

    #adding memoization per journal app walkthrough
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

  end

end
