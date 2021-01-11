class ItemsController < ApplicationController

  get '/items/new' do
    if logged_in?
      erb :'items/new'
    else
      redirect '/login'
    end
  end

  post '/items' do
    #binding.pry
    if logged_in?
      @user = current_user
      @item = Item.new(name: params[:name], description: params[:description], weight: params[:weight], image_url: params[:image_url])
      @user.items.push(@item)
      @user.save
      #binding.pry
      redirect "users/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  get '/items/:id' do
    @item = Item.find(params[:id])
    @user = User.find(session[:user_id])
    erb :'/items/show'
  end

  get '/items' do
    @items = Item.all
    erb :'items/index'
  end


end
