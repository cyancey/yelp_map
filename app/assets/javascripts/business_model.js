function BusinessModel(args) {
  for(var attribute in args) {
    var value = args[attribute]
    this[attribute] = value
  }
}

BusinessModel.prototype = {
  oneReview: function() {
    if(this.yelp_review_count === 1) {
      return true
    } else {
      return false
    }
  }
}