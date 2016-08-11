# Homepage (Root path)
get '/' do
  erb :landing
end

get '/listings' do
  erb :'listings/index'
end

get '/listings/map' do
  @listings = Listing.all
  erb :'listings/map'
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

post '/user/preferences' do
  max_price = (params[:max_price].nil?) ? 1000000 : params[:max_price]
  min_area = (params[:min_area].nil?) ? 0 : params[:min_area]
  min_bedrooms = (params[:min_bedrooms].nil?) ? 0 : params[:min_bedrooms]
  min_bathrooms = (params[:min_bathrooms].nil?) ? 0 : params[:min_bathrooms]
  @listings = Listing.where(
    "max_price < ? AND min_area > ? AND min_bedrooms > ? AND min_bathrooms > ?",max_price, min_area, min_bedrooms, min_bathrooms
    )
  erb :'listings/map'
end


