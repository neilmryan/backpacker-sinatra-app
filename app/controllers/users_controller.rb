class UsersController < ApplicationController

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      erb :'users/show'
    else
      redirect "/login"
    end
  end
end
