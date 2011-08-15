require 'uri'
require 'yajl'
require 'hashie'

module Skittles
	module Request
		# Perform an HTTP GET request
		def get(path, options = {}, headers = {}, raw = false)
			request(:get, path, options, headers, raw)
		end

		# Performs an HTTP POST request
		def post(path, options = {}, headers = {}, raw = false)
			request(:post, path, options, headers, raw)
		end

		# Performs an HTTP PUT request
		def put(path, options = {}, headers = {}, raw = false)
		  request(:put, path, options, headers, raw)
		end

		# Performs an HTTP DELETE request
		def delete(path, options = {}, headers = {}, raw = false)
		  request(:delete, path, options, headers, raw)
		end

		private
		  #Perform an HTTP request
		  def request(method, path, options, headers, raw)
		  	headers.merge!({
		  		'User-Agent' => user_agent
		  	})

		  	options.merge!({
		  		:client_id     => client_id,
		  		:client_secret => client_secret
		  	})

		  	options.merge!({
		  	  :v => Time.now.strftime('%Y%m%d')
		  	})

		  	begin
		  	  response = connection.request(method, paramify(path, options), headers)
		  	rescue OAuth2::Error => e
		  	  Skittles::Utils.handle_foursquare_error(e.response)
		  	else
		  	  Skittles::Error
		  	end

		  	unless raw
		  		result = Skittles::Utils.parse_json(response)
		  	end

		  	raw ? response : result.response
		  end

		  # Encode path and turn params into HTTP query.
      def paramify(path, params)
        URI.encode("#{path}?#{params.map { |k,v| "#{k}=#{v}" }.join('&')}")
      end
	end
end
