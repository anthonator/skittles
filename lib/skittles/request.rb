require 'uri'
require 'yajl'
require 'hashie'

module Skittles
	module Request
		# Perform an HTTP GET request
		def get(path, options = {}, raw = false)
			request(:get, path, options, raw)
		end
		
		# Performs an HTTP POST request
		def post(path, options = {}, raw = false)
			request(:post, path, options, raw)
		end
		
		# Performs an HTTP PUT request
		def put(path, options = {}, raw = false)
		  request(:put, path, options, raw)
		end
		
		# Performs an HTTP DELETE request
		def delete(path, options = {}, raw = false)
		  request(:delete, path, options, raw)
		end
		
		private
		  #Perform an HTTP request
		  def request(method, path, options, raw)
		  	headers = {
		  		'User-Agent' => user_agent
		  	}
		  	
		  	options.merge!({
		  		:client_id     => client_id,
		  		:client_secret => client_secret
		  	})
		  	
		  	begin
		  	  response = connection.request(method, paramify(path, options), headers)
		  	rescue OAuth2::AccessDenied => e
		  	  info = parse_json(e.response.body).meta
		  	  error = Skittles::Unauthorized.new
		  	  error.code = info.code.to_i
		  	  error.type = info.errorType
		  	  error.detail = info.errorDetail
		  	  raise error
		  	rescue OAuth2::HTTPError => e
		  	  info = parse_json(e.response.body).meta
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
		  	
		  	unless raw
		  		result = parse_json(response)
		  	end
		  	
		  	raw ? response : result.response
		  end
		  
		  # Encode path and turn params into HTTP query.
      def paramify(path, params)
        URI.encode("#{path}?#{params.map { |k,v| "#{k}=#{v}" }.join('&')}")
      end
      
      # Parses JSON and returns a Hashie::Mash
      def parse_json(json)
        Hashie::Mash.new(Yajl::Parser.new.parse(json))
      end
	end
end