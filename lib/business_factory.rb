module BusinessFactory
  extend self

  def generate(yelp_business_results)
    yelp_business_results.map {|result| Business.new(result)}
  end
end