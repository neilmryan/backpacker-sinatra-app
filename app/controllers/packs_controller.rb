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

      #find items by id and load them into the packs items array
      @packed_item_ids = params[:pack][:item_ids]
      @packed_item_ids.each do |item_id|
        @pack.items << Item.find_by(id: item_id)
      end

      #convert quantity array to string, store it in the db and make instance variable in '/packs/:id'
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

    #grab the quanity string from the db and convert to array
    if @pack.quantity_string
      @quantity_array = @pack.quantity_string.split(",")
    end
    #calculate the total pack weigtht
    @total_pack_grams = 0;
    @pack.user.items.each_with_index do |item, index|
      if @pack.items.include?(item)
        @total_pack_grams += item.weight * @quantity_array[index].to_i;
      end
    end
    #convert grams to pounds and ounces formula: lb = g * 0.0022046
    @total_pack_pounds = @total_pack_grams * 0.0022046;

    erb :'packs/show'
  end

  get '/packs/:id/edit' do
    @pack = Pack.find_by(id: params[:id])
    #grab the quanity string from the db and convert to array
    if @pack.quantity_string
      @quantity_array = @pack.quantity_string.split(",")
    end

    erb :'packs/edit'
  end

  patch '/packs/:id' do

    @pack = Pack.find_by(id: params[:id])
    if current_user == @pack.user
      #bug fix to prevent an error for a non existant item_ids array in the case all items are removed from a pack
      if !params.keys.include?("item_ids")
        @pack.items = [];
      end

      @pack.update(trip_name: params[:trip_name], length: params[:length], weather: params[:weather], image_url: params[:image_url], blurb: params[:blurb])

      #find items by id and load them into the packs items array
      if params.include?("pack")
        @packed_item_ids = params[:pack][:item_ids]
        @packed_item_ids.each do |item_id|
          @pack.items << Item.find_by(id: item_id)
        end
      end

      #convert quantity array to string, store it in the db and make instance variable in '/packs/:id'
      @pack.quantity_string = params[:quantity][:items].join(",");
      current_user.packs.push(@pack)
      current_user.save
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
