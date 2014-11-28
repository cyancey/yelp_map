class HomeController < ApplicationController
  def index
  end

  def coords_search
    results = YelpAPI.search_by_lat_lng(params)
    businesses = BusinessFactory.generate(results[:businesses])
    render json: businesses
  end

  def bounds_search
    results = YelpAPI.search_by_bounds(params)
    businesses = BusinessFactory.generate(results[:businesses])
    render json: businesses
  end

  def additional_yelp_details
    puts 'Additional Yelp Details Params'
    p params
    yelp_page = Nokogiri::HTML(open(params['yelp_page_url'],  "User-Agent" => ENV['USER_AGENT']))
    price_range = yelp_page.css('.price-range').children[0].text
    todays_hours = yelp_page.css('.island.summary .biz-hours .hour-range').text
    render json: {price_range: price_range,
                  todays_hours: todays_hours}
  end
end