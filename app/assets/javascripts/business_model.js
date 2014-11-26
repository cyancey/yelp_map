function BusinessModel(args) {
  for(var attribute in args) {
    var value = args[attribute]
    this[attribute] = value
  }
}

BusinessModel.prototype = {

}