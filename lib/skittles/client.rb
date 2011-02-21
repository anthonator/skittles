# Adapted from the Ruby Twitter gem.
# @see https://github.com/jnunemaker/twitter
module Skittles
	# Wrapper for the Foursquare v2 REST API
	#
	# @note All methods have been separated into modules and follow the same grouping used in {http://developer.foursquare.com/docs/}.
	# @see http://developer.foursquare.com/docs/index_docs.html
	class Client < API
		Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }
		
		include Skittles::Client::Venue
		include Skittles::Client::User
		include Skittles::Client::Checkin
		include Skittles::Client::Tip
		include Skittles::Client::Photo
	end
end