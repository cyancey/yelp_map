class Business
  def initialize(args = {})
    @rating = args.fetch('rating', nil)
    @name = args.fetch('name', nil)
    @yelp_id = args.fetch('id', nil)
    @yelp_review_count = args.fetch('review_count')
    @permenantly_closed = args.fetch('is_closed', nil)
    @phone = args.fetch('display_phone', nil)
    location = args.fetch('location', nil)
    @address = location.fetch('address', nil) if location
    @city = location.fetch('city', nil) if location
    @state = location.fetch('state_code', nil) if location
    @postal_code = location.fetch('postal_code', nil) if location
    @country = location.fetch('country_code', nil) if location
    @latitude = location['coordinate']['latitude'] if location && location['coordinate']
    @longitude = location['coordinate']['longitude'] if location && location['coordinate']
  end
end