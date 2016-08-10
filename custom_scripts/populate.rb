DEFAULT_URL = "https://vancouver.craigslist.ca/search/apa"

def create_listing(url)
  constructed_url = "https://vancouver.craigslist.ca/#{url}"
  doc = Nokogiri::HTML(open(constructed_url))

  if doc.at_css(".price")
    price = doc.at_css(".price").inner_text.match(/\d+/).to_s.to_i
  else
    price = nil
  end

  if doc.at_css(".housing")
    area = doc.at_css(".housing").inner_text.match(/(\d+){3,}/).to_s.to_i
  else
    area = nil
  end

  listing = Listing.new(price: price, area: area, url: url)
  listing.save
end

def find_listing_urls
  root_url = DEFAULT_URL
  doc = Nokogiri::HTML(open(root_url))
  a_elements = doc.css(".row > .txt > .pl > a").map{ |a| a["href"]}
end

find_listing_urls.each do |url|
  create_listing(url)
end