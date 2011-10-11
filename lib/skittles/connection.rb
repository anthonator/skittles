require 'oauth2'

module Skittles
	# @private
	module Connection
		private
		  def connection
		  	client = OAuth2::Client.new(client_id, client_secret, { :site => endpoint })
		  	oauth_token = OAuth2::AccessToken.new(client, access_token, {
		  	  :mode => :query, 
		  	  :param_name => 'oauth_token'
		  	})
		  	oauth_token
		  end
	end
end
