class ItemsController < ApplicationController

  #route to render a new item form
  get '/items/new' do
    if logged_in?
      erb :'items/new'
    else
      redirect '/login'
    end
  end

  #route to create a new item using params
  post '/items' do
    if logged_in?
      @user = current_user
      @item = Item.new(name: params[:name], description: params[:description], weight: params[:weight], image_url: params[:image_url])
      @user.items.push(@item)
      @user.save
      redirect "users/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  #route to load all users items
  get '/items/index' do
    @items = Item.all
    erb :'items/index'
  end

  #route to load an item by id
  get '/items/:id' do
    @item = Item.find(params[:id])
    erb :'/items/show'
  end

  #route to render an edit form for item
  get '/items/:id/edit' do
    @item = Item.find_by(id: params[:id])
    if current_user == @item.user
      erb :'items/edit'
    else
      flash[:message] = "Sorry, \nyou can't edit an item you did not post."
      redirect "/items/#{@item.id}"
    end
  end

  #route to update an item
  patch '/items/:id' do
    @item = Item.find_by(id: params[:id])
    @item.update(name: params[:name], description: params[:description], weight: params[:weight], image_url: params[:image_url])
    redirect "/items/#{@item.id}"
  end

  #route to delete an item
  delete '/items/:id/delete' do
    @item = Item.find_by(id: params[:id])
    if current_user == @item.user
      @item.destroy
      redirect "users/#{@item.user.slug}"
    else
      redirect "users/#{@item.user.slug}"
    end
  end

end
