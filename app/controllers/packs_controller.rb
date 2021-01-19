class PacksController < ApplicationController

  get '/packs/new' do
    if logged_in?
      @items = current_user.items
      erb :'packs/new'
    else
      redirect '/login'
    end
  end

  post '/packs' do
    if logged_in?
      @user = current_user
      @pack = Pack.new(trip_name: params[:trip_name], length: params[:length], weather: params[:weather], image_url: params[:image_url])

      @packed_item_ids = params[:pack][:item_ids]

      @packed_item_ids.each do |item_id|
        @pack.items << Item.find_by(id: item_id)
      end

      @quantity_items = params[:quantity][:items]
      @pack.quantity_string = @quantity_items.join(",");

      @user.packs.push(@pack)
      @user.save
      redirect "packs/#{@pack.id}"
    else
      redirect '/login'
    end
  end

  get '/packs/:id/blurb' do
    @pack = Pack.find_by(id: params[:id])
    erb :'packs/new_blurb'
  end

  post '/packs/:id/blurb' do
    @pack = Pack.find_by(id: params[:id])
    @pack.blurb = params[:blurb]
    @pack.save
    redirect "/packs/#{@pack.id}"
  end

  get '/packs/index' do
    @packs = Pack.all
    erb :'packs/index'
  end

  get '/packs/:id' do
    @pack = Pack.find_by(id: params[:id])

    @quantity_array = @pack.quantity_string.split(",")
    #@packed_items.each_with_index do |item, index|
    #  if @quantity_items[index] != ""
    #    @item_quantity[item] = @quantity_items[index]
    #  end
    #  @item_quantity
    #end


    erb :'packs/show'
  end

  get '/packs/:id/edit' do
    @pack = Pack.find_by(id: params[:id])
    erb :'packs/edit'
  end

  patch '/packs/:id' do
    @pack = Pack.find_by(id: params[:id])
    if current_user == @pack.user
      @pack.update(trip_name: params[:trip_name], length: params[:length], weather: params[:weather], image_url: params[:image_url], blurb: params[:blurb])
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
