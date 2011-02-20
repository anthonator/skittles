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
		  		:client_secret => client_secret,
		  		:oauth_token => access_token
		  	})
		  	response = connection.request(method, paramify(path, options), { 'oauth_token' => access_token }, headers)
		  	
		  	unless raw
		  		result = Yajl::Parser.new.parse(response)
		  	end
		  	
		  	raw ? response : Hashie::Mash.new(result).response
		  end
		  
		  # Encode path and turn params into HTTP query.
      def paramify(path, params)
        URI.encode("#{path}?#{params.map { |k,v| "#{k}=#{v}" }.join('&')}")
      end
	end
end