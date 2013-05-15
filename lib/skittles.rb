require 'uri'
require 'yajl'
require 'hashie'
require File.expand_path('../skittles/utils', __FILE__)
require File.expand_path('../skittles/error', __FILE__)
require File.expand_path('../skittles/version', __FILE__)
require File.expand_path('../skittles/configuration', __FILE__)
require File.expand_path('../skittles/api', __FILE__)
require File.expand_path('../skittles/client', __FILE__)

# Adapted from the Ruby Twitter gem.
# @see https://github.com/jnunemaker/twitter
module Skittles
	extend Configuration
	
	# Alias for Skittles::Client.new
	#
	# @return {Skittles::Client}
	def self.client(options = {})
		Skittles::Client.new(options)
	end
	
	# Delegate to Skittles::Client
	def self.method_missing(method, *args, &block)
		return super unless client.respond_to?(method)
		client.send(method, *args, &block)
	end
	
	# Delegate to Skittles::Client
	def self.respond_to?(method)
		return client.respond_to?(method) || super
	end
end
