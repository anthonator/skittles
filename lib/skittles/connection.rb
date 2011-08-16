require 'oauth2'

module Skittles
	# @private
	module Connection
		private
		  def connection
		  	options = {
		  		:site => endpoint
		  	}
		  	client = OAuth2::Client.new(client_id, client_secret, options)
		  	oauth_token = OAuth2::AccessToken.new(client, access_token, param_name: "oauth_token", mode: :query)

		  	oauth_token
		  end
	end
end
