# Homepage (Root path)
get '/' do
  @listings = Listing.all
  erb :index
end
