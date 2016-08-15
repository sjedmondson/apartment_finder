# Homepage (Root path)
require 'json'

helpers do
  def current_user
    @user = User.find(session[:user].id) if session[:user]
  end

  def get_notifications
    if current_user
      if current_user.preference
        user = current_user
        max_price = user.preference.max_price
        min_area = user.preference.min_area
        min_bedrooms = user.preference.min_bedrooms
        min_bathrooms = user.preference.min_bathrooms
        listings = Listing.where(
          "price < ? AND area > ? AND bedrooms > ? AND bathrooms > ?", 
          max_price, 
          min_area, 
          min_bedrooms, 
          min_bathrooms
        ).order(created_at: :desc).limit(6)
      else
        listings = Listing.where("1 = 2") # we don't like freakouts.  temp code.
      end
    end
  end

  def filter_listings
    user = current_user
    max_price = user.preference.max_price
    min_area = user.preference.min_area
    min_bedrooms = user.preference.min_bedrooms
    min_bathrooms = user.preference.min_bathrooms
    listings = Listing.where(
      "price < ? AND area > ? AND bedrooms > ? AND bathrooms > ?", 
      max_price, 
      min_area, 
      min_bedrooms, 
      min_bathrooms
    )
  end

end

get '/' do
  erb :landing
end

post '/comments' do
  @comment = Comment.new(
    content: params[:content],
    rating: params[:rating],
    listing_id: params[:listing_id],
    user_id: params[:user_id]
  )
  if @comment.save
    redirect "/comments/#{params[:listing_id]}"
  else
    @listing = Listing.find(params[:listing_id])
    erb :'comments/new'
  end
end

get '/comments/:listing_id' do 
  @listing = Listing.find(params[:listing_id])
  erb :'comments/new'
end

get '/listings' do
  erb :'listings/index'
end

get '/listings/map' do

  if current_user
    @listings = filter_listings
  else
    @listings = Listing.all
  end

  if current_user
    @notifications = get_notifications
  end
  erb :'listings/map'
end

get '/listings/create' do
  if current_user
    erb :'listings/create'
  else
    redirect '/user/login'
  end
end

post '/listings/map' do

  max_price = (params[:price].empty?) ? 1000000 : params[:price]
  min_area = (params[:area].empty?) ? 0 : params[:area]
  min_bedrooms = (params[:bedrooms].empty?) ? 0 : params[:bedrooms]
  min_bathrooms = (params[:bathrooms].empty?) ? 0 : params[:bathrooms]
  @listings = Listing.where(
    "price < ? AND area > ? AND bedrooms > ? AND bathrooms > ?",
    max_price, 
    min_area, 
    min_bedrooms, 
    min_bathrooms
    )
  json({listings: @listings}) 

end

get '/listings/:listing_id' do
  @listing = Listing.find(params[:listing_id])
  if @listing.user == current_user
    erb :'listings/edit'
  else
    redirect '/user/listings'
  end
end

post '/listing/:listing_id' do
  @listing = Listing.find(params[:listing_id])
  if @listing.update(params[:listing])
    redirect '/user/listings'
  else
    erb :'listings/edit'
  end
end

get '/listings/:listing_id/details' do
  @listing = Listing.find(params[:listing_id])
  erb :'/listings/details'
end

get '/listings/:listing_id/destroy' do
  listing = Listing.find(params[:listing_id])
  if listing.user = current_user
    listing.destroy
    redirect '/user/listings'
  else
    redirect '/users/listings'
  end
end

# get '/listings/:listing_id' do 
#   @listing = Listing.find(params[:listing_id])
#   @listing.created_at.to_s
# end

post '/listings' do
  @listing = Listing.new(
    user_id: current_user.id,
    price: params[:price],
    area: params[:area],
    street_address: params[:street_address],
    bedrooms: params[:bedrooms],
    bathrooms: params[:bathrooms],
    )
  @listing.images.new(image: params[:image]) if params[:image]
  if @listing.save
    redirect '/listings/map'
  else
    erb :'listings/create'
  end
end

post '/user/preferences' do
  @preference = current_user.preference
  @preference.update(params)

  if @preference.save
    redirect '/listings/map'
  else
    erb :'/user/preferences'
  end
end

get '/user/preferences' do
  erb :'user/preferences'
end

get '/user/listings' do
  user = current_user
  if user
    @listings = user.listings
    erb :'user/listings'
  else
    redirect 'listings/map'
  end
end

get '/user/login' do
  @notoolbar = true
  erb :'user/login'
end

get '/user/logout' do 
  session[:user] = nil
  redirect '/'
end

post '/user/login' do
  @user = User.find_by username: params[:username]
  if @user && @user.password == params[:password]   # please do not use such bad security ever again
    session[:user] = @user
    redirect '/listings/map'
  else
    redirect '/'
  end
end

get '/user/create' do
  @notoolbar = true
  erb :'user/create'
end

post '/user' do 
  @user = User.new(params)
  if @user.save
    redirect '/'
  else
    erb :'user/create'
  end
end

get '/user/profile' do
  @user = current_user
  erb :'user/profile'
end

