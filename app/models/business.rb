class Business
  def initialize(args = {})
    @rating = args.fetch('rating', nil)
    @rating_image_url = args.fetch('rating_img_url_small', nil)
    @name = args.fetch('name', nil)
    @yelp_id = args.fetch('id', nil)
    @yelp_review_count = args.fetch('review_count')
    @yelp_page_url = args.fetch('mobile_url', nil)
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
    @categories = args.fetch('categories', []).map{|category_arr| category_arr[0]}
    @categories_string = @categories.join(', ')
  end
end