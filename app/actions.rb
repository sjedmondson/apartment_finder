# Homepage (Root path)
helpers do
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  erb :landing
end

get '/listings' do
  erb :'listings/index'
end

get '/listings/map' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    @listings = Listing.all
    erb :'listings/map'
  else
    redirect "/"
  end
end

get '/listings/create' do
  erb :'listings/create'
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

post '/listings/map' do
  max_price = (params[:price].empty?) ? 1000000 : params[:price]
  min_area = (params[:area].empty?) ? 0 : params[:area]
  min_bedrooms = (params[:bedrooms].empty?) ? 0 : params[:bedrooms]
  min_bathrooms = (params[:bathrooms].empty?) ? 0 : params[:bathrooms]
  @listings = Listing.where(
    "price < ? AND area > ? AND bedrooms > ? AND bathrooms > ?",max_price, min_area, min_bedrooms, min_bathrooms
    )
  erb :'listings/map'
end

get '/user/login' do
  erb :'user/login'
end

post '/user/login' do
  @user = User.find_by username: params[:username]
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/listings/map'
  else
    erb :'/'
  end
end

get '/user/create' do
  erb :'user/create'
end

# post '/user/logout' do

# end
