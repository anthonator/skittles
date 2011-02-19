# Adapted from the Ruby Twitter gem.
# @see https://github.com/jnunemaker/twitter
module Skittles
	# Defines constants and methods related to configuration.
	module Configuration
		# An array of valid keys in the options hash when configuring a {Flixated::API}.
		VALID_OPTIONS_KEYS = [
			:access_token,
			:authorization_endpoint,
			:client_id,
			:client_secret,
			:endpoint,
			:proxy,
			:user_agent
		].freeze
	
		# By default, don't set a user access token.
		DEFAULT_ACCESS_TOKEN = nil.freeze
		
		# The endpoint that will be used to authorize a user if none is set.
		DEFAULT_AUTHORIZATION_ENDPOINT = 'https://foursquare.com/oauth2/authenticate'.freeze
		
		# By default, don't set a client id.
		DEFAULT_CLIENT_ID = nil.freeze
		
		# By default, don't set a cliet secret.
		DEFAULT_CLIENT_SECRET = nil.freeze
		
		# The endpoint that will be used to connect if none is set.
		DEFAULT_ENDPOINT = 'https://api.foursquare.com/v2'.freeze
		
		# By default, don't set a proxy server.
		DEFAULT_PROXY = nil.freeze
		
		# The user agent that will be setn to the API endpoint if none is set.
		DEFAULT_USER_AGENT = "skittles gem v#{Skittles::VERSION}".freeze
		
		# @private
		attr_accessor(*VALID_OPTIONS_KEYS)
		
		# When this module is extended, set all configuration options to their default values.
		def self.extended(base)
			base.reset
		end
		
		# Convenience method to allow configuration options to be set in a block.
		def configure
			yield self
		end
		
		# Create a hash of options and their values.
		def options
			VALID_OPTIONS_KEYS.inject({}) do |option,key|
				option.merge!(key => send(key))
			end
		end
		
		# Reset all configuration options to default.
		def reset
			self.access_token           = DEFAULT_ACCESS_TOKEN
			self.authorization_endpoint = DEFAULT_AUTHORIZATION_ENDPOINT
			self.client_id              = DEFAULT_CLIENT_ID
			self.client_secret          = DEFAULT_CLIENT_SECRET
			self.endpoint               = DEFAULT_ENDPOINT
			self.proxy                  = DEFAULT_PROXY
			self.user_agent             = DEFAULT_USER_AGENT
		end
	end
end