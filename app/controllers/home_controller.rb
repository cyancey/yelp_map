class HomeController < ApplicationController
  def index
  end

  def coords_search
    results = YelpAPI.search_by_lat_lng(params)
    businesses = BusinessFactory.generate(results[:businesses])
    render json: businesses

  end
end