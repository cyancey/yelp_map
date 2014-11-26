function MapController(applicationController) {
  this.map = null
  this.parent = applicationController
  this.markers = []
}

MapController.prototype = {
  init: function() {
    var mapOptions = {
          center: { lat: 40.183988, lng: -95.726231},
          zoom: 4
        };
    this.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  },

  updateMap: function(coords) {
    this.map.panTo(coords)
    this.map.setZoom(13)
    var ajaxRequest = $.ajax({
      url: '/coords_search',
      type: 'GET',
      data: coords
    })

    ajaxRequest.done(this.buildModelsSetMarkers.bind(this))
  },

  buildModelsSetMarkers: function(businesses) {
    var businessCount = businesses.length
    for(var i=0; i<businessCount; i++) {
      var business = businesses[i]
      this.parent.models.businesses.push(new BusinessModel(business))
    }
    this.clearMarkers()
    this.setBusinessMarkers()
  },

  clearMarkers: function() {
    var markers = this.markers,
        markerCount = markers.length

    for(var i=0; i<markerCount; i++) {
      var marker = markers[i]
      marker.setMap(null)
    }

    markers = null
  },

  setBusinessMarkers: function() {
    var businessModels = this.parent.models.businesses
    var businessModelCount = businessModels.length
    for(var i=0; i<businessModelCount; i++) {
      var businessModel = businessModels[i]
      this.createBusinessMarker(businessModel)
    }
  },

  createBusinessMarker: function(businessModel) {
    var marker = new google.maps.Marker({
        position: {lat: businessModel.latitude, lng: businessModel.longitude},
        map: this.map,
        title: businessModel.name
    })
    this.markers.push(marker)
  }

}