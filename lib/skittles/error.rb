module Skittles
  # Custom error class for rescuing from all known Foursquare errors.
  class Error < StandardError; attr_accessor :code, :type, :detail end
  
  # Raised when Foursquare returns HTTP status code 400
  class BadRequest < Error; end
  
  # Raised when Foursquare returns HTTP status code 401
  class Unauthorized < Error; end
  
  # Raised when Foursquare returns HTTP status code 404
  class NotFound < Error; end
  
  # Raised when Foursquare returns HTTP status code 405
  class MethodNotAllowed < Error; end
  
  # Raised when Foursquare returns HTTP status code 500
  class InternalServerError < Error; end
  
  # Raised when Foursquare returns HTTP status code 502
  class BadGateway < Error; end
  
  # Raised when Foursquare returns HTTP status code 503
  class ServiceUnavailable < Error; end
  
  # Raised when Foursquare returns HTTP status code 504
  class GatewayTimeout < Error; end
end