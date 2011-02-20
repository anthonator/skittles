require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)

# Adapted from the Ruby Twitter gem.
# @see https://github.com/jnunemaker/twitter
module Skittles
	# @private
	class API
		# @private
		attr_accessor(*Configuration::VALID_OPTIONS_KEYS)
		
		# Creates a new API
		def initialize(options = {})
			options = Skittles.options.merge(options)
			Configuration::VALID_OPTIONS_KEYS.each do |key|
				send("#{key}=", options[key])
			end
		end
		
		include Connection
		include Request
	end
end
