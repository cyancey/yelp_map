module YelpAPI
  extend self
  DEFAULT_SEARCH_OPTIONS = {
    sort_mode: 2 #highest rated
  }

  def search_by_location_name(args = {})
    search_params = DEFAULT_SEARCH_OPTIONS.merge(args)
    location = search_params.delete(:location)
    results = JSON.parse(Yelp.client.search(location, search_params).to_json)
    {region: results.fetch('region', nil),
     businesses: results.fetch('businesses', nil)}
  end

  def search_by_lat_lng(args = {})
    search_params = DEFAULT_SEARCH_OPTIONS.reject{|k,v| k==:location}.merge(args)
    results = JSON.parse(Yelp.client.search_by_coordinates(
      {latitude: search_params.delete('lat'),
       longitude: search_params.delete('lng')},
       search_params).to_json)
    {region: results.fetch('region', nil),
     businesses: results.fetch('businesses', nil)}
  end

  def custom_search(args = {})
    search_params = DEFAULT_SEARCH_OPTIONS.reject{|k,v| k==:location}.merge(args)
    bounding_box = extract_bounding_box(search_params)

    search_params = {term: search_params.delete('term')}

    p bounding_box
    p search_params

    results = JSON.parse(Yelp.client.search_by_bounding_box(bounding_box, search_params).to_json)
    {region: results.fetch('region', nil),
     businesses: results.fetch('businesses', nil)}
  end

  def search_by_bounds(args = {})
    search_params = DEFAULT_SEARCH_OPTIONS.reject{|k,v| k==:location}.merge(args)
    bounding_box = extract_bounding_box(search_params)
    puts 'Bounding Box Coordinates'
    p bounding_box
    puts 'Search Params'
    search_params = build_search_params(search_params.delete('search_type'))
    p search_params
    results = JSON.parse(Yelp.client.search_by_bounding_box(bounding_box, search_params).to_json)
    {region: results.fetch('region', nil),
     businesses: results.fetch('businesses', nil)}
  end

  private

  def build_search_params(search_type)
    puts search_type
    if search_type == 'restaurants'
      {term: 'restaurants'}
    elsif search_type == 'coffee'
      {term: 'coffee',
       categories: 'coffee'}
    elsif search_type == 'bars'
      {term: 'bars',
       categories: 'bars'}
    end
  end

  def extract_bounding_box(search_params)
    {sw_latitude: search_params.delete("sw_latitude"),
      sw_longitude: search_params.delete("sw_longitude"),
      ne_latitude: search_params.delete("ne_latitude"),
      ne_longitude: search_params.delete("ne_longitude")}
  end
end
