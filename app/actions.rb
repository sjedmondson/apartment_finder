# Homepage (Root path)
helpers do
  def current_user
    @user = User.find(session[:user].id) if session[:user]
  end

  def get_notifications
    if current_user
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
    end
  end

end

get '/' do
  erb :landing
end

get '/listings' do
  erb :'listings/index'
end

get '/listings/map' do
  @user = current_user
  @listings = Listing.all
  if current_user
    @notifications = get_notifications
  end
  erb :'listings/map'
end

get '/listings/create' do
  erb :'listings/create'
end

get '/listings/edit' do
  erb :'listings/edit'
end

get '/listings/:listing_id' do 
  @listing = Listing.find(params[:listing_id])
  @listing.created_at.to_s
end

post '/listings' do
  @listing = Listing.new(
    price: params[:price],
    area: params[:area],
    street_address: params[:street_address],
    bedrooms: params[:bedrooms],
    bathrooms: params[:bathrooms]
    )
  if @listing.save
    redirect '/listings/map'
  else
    erb :'listings/create'
  end
end

get '/user/preferences' do
  erb :'user/preferences'
end

get '/user/listings' do 
  if current_user
    @listings = Listing.where(user_id: current_user.id)
    "this is the user listings page"
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
  erb :'listings/map'
end

get '/user/login' do
  erb :'user/login'
end

post "/user/login" do
  # userTable = User.where(username: params[:user_name], password: params[:password])
  user = User.find_by(username: params[:user_name], password: params[:password])
  
  if user
    session[:user] ||= user
    redirect '/'
  else
    # erb :'login/error'  
  end
end
