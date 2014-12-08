class HomeController < ApplicationController
  def index
  end

  # def term_search

  # end

  def coords_search
    results = YelpAPI.search_by_lat_lng(params)
    businesses = BusinessFactory.generate(results[:businesses])
    render json: businesses
  end

  def custom_search
    results = YelpAPI.custom_search(params)
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
    todays_hours = parse_todays_hours(yelp_page)
    # todays_hours = yelp_page.css('.island.summary .biz-hours .hour-range').text
    render json: {price_range: price_range,
                  todays_hours: todays_hours}
  end

  private

  def parse_todays_hours(yelp_page)
    if yelp_page.css('.island.summary .biz-hours .hour-range span').length > 2
      hours_text =  /(.+(am|pm))(\d.+)/.match(yelp_page.css('.island.summary .biz-hours .hour-range').text)
      [{hours_text: hours_text[1]}, {hours_text: hours_text[3]}]
    elsif yelp_page.css('.island.summary .biz-hours .hour-range span').length == 2
      [{hours_text:yelp_page.css('.island.summary .biz-hours .hour-range').text}]
    else
      nil
    end
  end
end