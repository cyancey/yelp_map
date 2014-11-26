module YelpAPI
  extend self
  DEFAULT_SEARCH_OPTIONS = {
    location: 'San Francisco',
    term: 'restaurants',
    sort_mode: 2, #highest rated
    latitude: 19.572417,
    longitude: -155.966742
  }

  def search_by_location_name(args = {})
    search_params = DEFAULT_SEARCH_OPTIONS.reject{|k,v| k==:latitude || k==:longitude}.merge(args)
    location = search_params.delete(:location)
    results = JSON.parse(Yelp.client.search(location, search_params).to_json)
    {region: results.fetch('region', nil),
     businesses: results.fetch('businesses', nil)}
  end

  def search_by_lat_lng(args = {})
    search_params = DEFAULT_SEARCH_OPTIONS.reject{|k,v| k==:location}.merge(args)
    results = JSON.parse(Yelp.client.search_by_coordinates(
      {latitude: search_params.delete(:latitude),
       longitude: search_params.delete(:longitude)},
       search_params).to_json)
    {region: results.fetch('region', nil),
     businesses: results.fetch('businesses', nil)}
  end
end