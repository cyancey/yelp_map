module LocuAPI
  extend self

  def venue_search(params)
    search_query = {name: params.fetch('name', nil),
                    location: {
                      geo: {
                        '$in_lat_lng_radius' => [params.fetch('lat', nil),
                                                 params.fetch('lng', nil),
                                                 1000]
                      }
                    }
    }

    response = HTTParty.post('https://api.locu.com/v2/venue/search/',
                             body: {api_key: ENV['LOCU_API_KEY'],
                                    fields: ['website_url', 'name', 'external'],
                                    venue_queries: [search_query]}.to_json

    )
    response['venues'].first
  end

end