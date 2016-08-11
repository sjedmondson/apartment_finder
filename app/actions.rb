# Homepage (Root path)
get '/' do
  @listings = Listing.all
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




