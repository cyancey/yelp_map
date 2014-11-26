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
    navigator.geolocation.getCurrentPosition(function(position) {
      coords = {lat: position.coords.latitude, lng: position.coords.longitude}
      this.mapController.updateMap(coords)
    }.bind(this))
  }
}