class PacksController < ApplicationController

  get '/packs/new' do
    if logged_in?
      erb :'packs/new'
    else
      redirect '/login'
    end
  end

  post '/packs' do
    if logged_in?
      @user = current_user
      @pack = Pack.new(trip_name: params[:trip_name], length: params[:length], weather: params[:weather], image_url: params[:image_url])
      @user.packs.push(@pack)
      @user.save
      #binding.pry
      redirect "users/#{@user.slug}/packs"
    else
      redirect '/login'
    end
  end

  get '/packs/index' do
    @packs = Pack.all
    erb :'packs/index'
  end

  get '/packs/:id' do
    @pack = Pack.find_by(id: params[:id])
    erb :'packs/show'
  end

  get '/packs/:id/edit' do
    @pack = Pack.find_by(id: params[:id])
    erb :'packs/edit'
  end

  patch '/packs/:id' do
    @pack = Pack.find_by(id: params[:id])
    if current_user == @pack.user
      @pack.update(trip_name: params[:trip_name], length: params[:length], weather: params[:weather], image_url: params[:image_url])
      redirect "/packs/#{@pack.id}"
    else
      flash[:message] = "Sorry, \nyou can't edit a pack you did not create."
      redirect "/packs/#{@pack.id}"
    end
  end

  delete '/packs/:id/delete' do
    @pack = Pack.find_by(id: params[:id])
    if current_user == @pack.user
      @pack.destroy
      redirect "users/#{@pack.user.slug}/packs"
    else
      redirect "users/#{@pack.user.slug}/packs"
    end
  end

end
