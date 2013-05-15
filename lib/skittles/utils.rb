module Skittles
  # @private
  module Utils
    private 
      def self.handle_foursquare_error(response)
        info = parse_json(response.body).meta
        error = case info.code.to_i
        when 400 then BadRequest.new
        when 401 then Unauthorized.new
        when 404 then NotFound.new
        when 405 then MethodNotAllowed.new
        when 500 then InternalServerError.new
        when 502 then BadGateway.new
        when 503 then ServiceUnavailable.new
        when 504 then GatewayTimeout.new
        else Error.new
        end
        error.code = info.code.to_i
        error.type = info.errorType
        error.detail = info.errorDetail
        raise error
      end
      
      # Parses JSON and returns a Hashie::Mash
      def self.parse_json(json)
        Hashie::Mash.new(MultiJson.load(json))
      end

      def deprecated(deprecated_method, replacement_method)
        warn "[DEPRECATED] Skittles##{deprecated_method} is depcrecated. Please use Skittles##{replacement_method} instead."
      end
  end
end
