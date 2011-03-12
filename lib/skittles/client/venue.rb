module Skittles
	class Client
		# Defines methods related to venues.
		# @see http://developer.foursquare.com/docs/venues/venues.html
		module Venue
		  # Adds a new venue.
      #
      # All fields are optional, but one of either a valid address or a
      # geolat/geolong pair must be provided. It is recommended that a
      # geolat/geolong pair is provided in every case.
      #
      # Optionally, a category(primarycategoryid) may be passed in to which
      # this venue is to be assigned. A full list of categories using the
      # {http://developer.foursquare.com/docs/venues/categories.html /categories}
      # method.
      #
      # @param name [String] The name of the venue.
      # @param options [Hash] A customizable set of options.
      # @option options [String] address The address of the venue.
      # @option options [String] crossStreen The nearest intersecting street or streets.
      # @option options [String] city The city name where this venue is.
      # @option options [String] state The nearest state or province to the venue.
      # @option options [String] zip The zip or postal code for the venue.
      # @option options [String] phone The phone number of the venue.
      # @option options [String] ll Latitude and longitude of the venue, as accurate as is known.
      # @option options [String] primaryCategoryId The id of the category to which you want to assign this venue.
      # @return [Hashie::Mash] Details about the venue that was just added.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/venues/add.html
      def add_venue(name, options = {})
        post('venues/add', { :name => name }.merge(options)).venue
      end
      
		  # Returns a hierarchical list of categories applied to venues. Note
      # that top-level categories do not have ids because they cannot be
      # assigned to a venue.
      #
      # Category images that come down through the API are available in three
      # sizes:
      # * 32 x 32 (default)
      # * 64 x 64
      # * 256 x 256
      # @return [Hashie::Mash] A heirarchical list of categories applied to venues.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/venues/categories.html
      def categories
        get('venues/categories').categories
      end
      
      # Allows a user to indicated a venue is incorrect in some way.
      #
      # @param id [String] The venue id for which an edit is being proposed.
      # @param problem [String] One of mislocated, closed, duplicate.
      # @require_acting_user Yes
      # @see http://developer.foursquare.com/docs/venues/flag.html
      def flag_venue(id, problem)
        post("venues/#{id}/flag", { :problem => problem })
        nil
      end
      
      # Provides a count of how many people are at a given venue, plus the
      # first page of the users there, friends-first, and if the current user
      # is authenticated.
      #
      # @note This is an experimental API.
      # @param id [String] Id of a venue to retrieve.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 500.
      # @option options [Integer] offset Used to page through results.
      # @option options [Integer] afterTimestamp Retrieve the first results to follow these seconds since epoch.
      # @return [Hashie::Mash] A count of items where items are checkins.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/venues/herenow.html 
      def herenow(id, options = {})
        get("venues/#{id}/herenow", options).hereNow
      end
			
			# Returns photos for a venue.
      #
      # @param id [String] The venue you want photos for.
      # @param group [String] One of checkin, venue or multi (for both).
      # @param  options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 500.
      # @option options [Integer] offset Used to page through results.
      # @return [Hashie::Mash] A count of items of photo.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/venues/photos.html
      def photos(id, group = 'checkin', options = {})
        get("venues/#{id}/photos", {:group => group }.merge(options)).photos
      end
      
      # Allows you to propose a change to a venue.
      #
      # @param id [String] The venue id for which an edit is being proposed.
      # @param name [String] The name of the venue.
      # @param address [String] The address of the venue.
      # @param city [String] The city name where the venue is.
      # @param state [String] The nearest state or province to the venue.
      # @param zip [String] The zip or postal code for the venue.
      # @param ll [String] Latitude and longitude of the venue's location, as accurate as is known.
      # @param options [Hash] A customizable set of options.
      # @option options [String] crossStreet The nearest intersecting street or streets.
      # @option options [String] phone The phone number of the venue.
      # @option options [String] primaryCategoryId The id of the category to which you want to assign this venue.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/venues/proposeedit.html
      def proposeedit(id, name, address, city, state, zip, ll, options = {})
        post("venues/#{id}/proposeedit", {
          :name => name,
          :address => address,
          :city => city,
          :state => state,
          :zip => zip,
          :ll => ll
        }.merge(options))
        nil
      end
      
      # Returns a list of venues near the current location with the most people
      # currently checked in.
      #
      # @note This is an experimental API.
      # @param ll [String] Latitude and longitude of the user's location.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 50.
      # @option options [Integer] radius Radius in meters, up to approximately 2000 meters.
      # @return An array of venues that are currently trending, with their hereNow populated.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/venues/trending.html
      def trending(ll, options = {})
        get('venues/trending', { :ll => ll }.merge(options)).venues
      end
			
			# Gives details about a venue, including location, mayorship, tags, tips,
      # specials and category.
      #
      # Authenticated users will also receive information about who is here now.
      #
      # If the venue id given is one that has been merged into another "master"
      # venue, the response will show data about the "master" instead of giving
      # you an error.
      #
      # @param id [String] Id of a venue to retrieve.
      # @return [Hashie::Mash] Details about a venue, including location, mayorship, tags, tips, specials, and category.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/venues/venues.html 
      def venue(id)
        get("venues/#{id}").venue
      end
      
      # Allows a user to mark a venue to-do, with optional text.
      #
      # @param id The venue you want to mark to-do.
      # @param options [Hash] A customizable set of options.
      # @option options [String] text The text of the tip.
      # @return [Hashie::Mash] The newly-added to-do, which contains a tip created implicitly.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/venues/marktodo.html
      def venue_marktodo(id, options = {})
        post("venues/#{id}/marktodo").todo
      end
			
			# Returns a list of venues near the current location, optionally matching
			# the search term.
			#
			# If lat and long is provided, each venue includes a distance. If
			# authenticated, the method will return venue metadata related to you and
			# your friends. If you do not authenticate, you will not get this data. 
			#
			# @param ll [String] Latitude and longitude of the user's location, so response can include distance.
			# @param options [Hash] A customizable set of options.
			# @option options [Decimal] llAcc Accuracy of latitude and longitude, in meters.
			# @option options [Decimal] alt Altitude of the user's location, in meters.
			# @option options [Decimal] altAcc Accuracy of the user's altitude, in meters.
			# @option options [String] query A search term to be applied against titles.
			# @option options [Integer] limit Number of results to return, up to 50.
			# @option options [String] intent Indicates your intent in performing the search.
			# @return [Hashie::Mash] An array of objects representing groups of venues.
			# @requires_acting_user No
			# @see http://developer.foursquare.com/docs/venues/search.html 
			def venue_search(ll, options = {})
			  get('venues/search', { :ll => ll }.merge(options)).groups
			end
			
			# Returns tips for a venue.
      #
      # @param id [String] The venue you want tips for.
      # @param options [Hash] A customizable set of options.
      # @option options [String] sort One of recent or popular.
      # @option options [Integer] limit Number of results to return, up to 500.
      # @option options [Integer] offset Used to page through results.
      # @return [Hashie::Mash] A count of items of tips.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/venues/tips.html
      def venue_tips(id, options = {})
        get("venues/#{id}/tips", options).tips
      end
		end
	end
end