module Skittles
  # @private
  module Utils
    private
      def self.handle_foursquare_error(response)
        info = parse_json(response).meta
        case info.code.to_i
        when 400
          error = Skittles::BadRequest.new
        when 401
          error = Skittles::Unauthorized.new
        when 404
          error = Skittles::NotFound.new
        when 405
          error = Skittles::MethodNotAllowed.new
        when 500
          error = Skittles::InternalServerError.new
        when 502
          error = Skittles::BadGateway.new
        when 503
          error = Skittles::ServiceUnavailable.new
        when 504
          error = Skittles::GatewayTimeout.new
        else
          error = Skittles::Error.new
        end
        error.code = info.code.to_i
        error.type = info.errorType
        error.detail = info.errorDetail
        raise error
      end

      # Parses JSON and returns a Hashie::Mash
      def self.parse_json(json)
        Hashie::Mash.new(Yajl::Parser.new.parse(json.is_a?(String) ? json : json.body))
      end
  end
end
