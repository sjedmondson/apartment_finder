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




