class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'yelp_api'
  require 'locu_api'
  require 'business_factory'
  require 'nokogiri'
  require 'open-uri'
end
