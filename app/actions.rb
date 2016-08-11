# Homepage (Root path)
get '/' do
  erb :index
end

get '/listings' do
  erb :'listings/index'
end

get '/favorites' do
  erb :'favorites/index'
end

get '/create' do
  erb :'listings/create'
end

post '/listing' do
  @listing = Listing.new(
    price: params[:price],
    area: params[:area],
    street_address: params[:street_address],
    bedrooms: params[:bedrooms],
    bathrooms: params[:bathrooms]
    )
  if @listing.save
    redirect '/listings'
  else
    erb :'listing/create'
  end
end





