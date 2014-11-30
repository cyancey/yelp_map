function ApplicationController() {
  this.mapController = new MapController(this)
  this.models = {businesses: []}
}

ApplicationController.prototype = {
  init: function() {
    this.mapController.init()
    this.getCurrentLocation()
  },

  getCurrentLocation: function() {
    navigator.geolocation.getCurrentPosition(this.obtainResultsSetMap.bind(this),
      this.locationError.bind(this),
      {enableHighAccuracy: true})
  },

  obtainResultsSetMap: function(position) {
    var coords = {lat: position.coords.latitude, lng: position.coords.longitude}
    this.mapController.updateMap(coords)
  },

  locationError: function() {
    //handle location error
  },

  selectByAttributeId: function(array, attributeType, attribute) {
    var arrayLength = array.length
    var results = []
    for(var i=0; i<arrayLength; i++) {
      if (array[i][attributeType] === attribute) {
        results.push(array[i])
      }
    }
    return results
  },

  findByAttribute: function(array, attributeType, attribute) {
    var arrayLength = array.length
    var results = []
    for(var i=0; i<arrayLength; i++) {
      if (array[i][attributeType] === attribute) {
        results.push(array[i])
      }
    }
    return results[0]
  }
}