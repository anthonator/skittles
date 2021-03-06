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

      # Allows changes to be made to a venue. Any blank parameter deletes an
      # an old value, any unspecified parameter does nothing.
      #
      # @param id [String] id of the venue to edit.
      # @param options [Hash] A customizable set of options.
      # @option options [String] name
      # @option options [String] address
      # @option options [String] crossStreet
      # @option options [String] city
      # @option options [String] state
      # @option options [String] zip
      # @option options [String] phone
      # @option options [String] ll
      # @option options [String] categoryId
      # @option options [String] url
      # @option options [String] hours
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/venues/edit
      def edit_venue(id, options = {})
        post("venues/#{id}/edit", options)
      end
      
      # Returns a list of recommended venues near the current location.
      #
      # @note This is an experimental API.
      # @param ll [String] Latitude and longitude of the user's location.
      # @param options [Hash] A customizable set of options.
      # @option options [Decimal] llAcc Accuracy of latitude and longitude, in meters.
      # @option options [Decimal] alt Altitude of the user's location, in meters.
      # @option options [Decimal] altAcc Accuracy of the user's altitude, in meters.
      # @option options radius [Integer] Radius to search within, in meters.
      # @option options section [String] One of food, drinks, coffee, shops, or arts. Limits results to venues with categories matching these terms.
      # @option options query [String] A search term to be applies against tips, category tips, etc. at a venue.
      # @option options limit [Integer] Number of results to return, up to 50.
      # @option options basis [String] If present and set to friends or me, limits results to only places where friends have visited or user has visited, respectively.
      # @option options [String] novelty Pass new or old to limit results to places the acting user hasn't been or has been, respectively. Omitting this parameter returns a mixture.
      # @return [Hashie::Mash] Response fields keywords, warnings and groups.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/venues/explore.html
      def explore(ll, options = {})
        get('venues/explore', { :ll => ll }.merge(options)).groups
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

      # Allows the acting user to like or unlike a venue.
      #
      # @param id [String] Id of the venue to like or unlike.
      # @param set [Integer] If 1, like this venue. If 0 unlike this venue. Default is 1.
      # @return [Hashie::Mash] Updated count and groups of users who like this venue.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/venues/like
      def like_venue(id, set = 1)
        post("venues/#{id}/like", { :set => set }).likes
      end
			
			# Get a list of venues the current user manages.
			#
			# @return [Hashie::Mash] An array of compact venues the user manages.
			# @require_acting_user Yes
			# @see https://developer.foursquare.com/docs/venues/managed
			def managed_venues
			  get('venues/managed').venues
			end
			
			# Returns menu information for a venue.
			#
			# @note In some cases, menu information is provided by a partner. When displaying information from a partner, you must attribute them as specified on the {https://developer.foursquare.com/docs/venues/menu Foursquare Developers} site.
			# @param id [String] The venue id for which menu is being requested.
			# @return [Hashie::Mash] Name of the provider of the menu information and a count and items of menu. 
			# @require_acting_user No
			# @see https://developer.foursquare.com/docs/venues/menu
			def menu(id)
			  get("venues/#{id}/menu")
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
      
      # Returns a list of venues similar to the specified venue.
      #
      # @param id [String] The venue you want similar venues for.
      # @return [Hashie::Mash] A count and items of similar venues.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/venues/similar
      def similar_venues(id)
        get("venues/#{id}/similar").similarVenues
      end
      
      # Get daily venue stats for a list of venues over a time range.
      #
      # @param ids [Array] A string array of venue ids to retrieve series data for.
      # @param start_at [Integer] The start of the time range to retrieve stats for (seconds since epoch).
      # @param options [Hash] A customizable set of options.
      # @options option [Integer] endAt The end of the time range to retrieve stats for (seconds since epoch). If omitted, the current time is assumed.
      # @return [Hashie::Mash] An array of venue time series data objects, one for each venue.
      # @require_acting_user Yes
      # @see https://developer.foursquare.com/docs/venues/timeseries
      def timeseries(ids, start_at, options = {})
        ids = ids.joing(',') if ids.kind_of? Array
        get('venues/timeseries', { :venueId => ids, :startAt => start_at }.merge(options))
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
      
      # Allows access to information about the current events at a place.
      #
      # At this time we are only able to distrubute Music events and limited information about Movie events via this endpoint due to partner restrictions.
      #
      # @param id Id of the venue to return event information for.
      # @return A count and items of event items.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/venues/events
      def venue_events(id)
        get("venues/#{id}/events").events
      end

      # Returns hours for a venue
      #
      # @params id [String] Id of a venue to return hours for.
      # @return An array of timeframes for hours.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/venues/hours
      def venue_hours(id)
        get("venues/#{id}/hours").hours
      end
      
      # Returns friends and a total count of users who have liked this venue.
      #
      # @param id Id of the venue to return likes for.
      # @return A count and groups of users who like this venue.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/venues/likes
      def venue_likes(id)
        get("venues/#{id}/likes").likes
      end

      # Returns URLs or identifier from third parties that have been applied to this
      # venue.
      #
      # @note This is an experimental API.
      # @param id [String] The venue you want annotations for.
      # @return [Hashie::Mash] A count and items of links.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/venues/links.html
      def venue_links(id)
        get("venues/#{id}/links").links
      end
      
      # The lists that a venue appears on.
      #
      # @param id [String] The venue to get lists for.
      # @param options [Hash] A customizable set of options.
      # @option options [String] group Either created, edited, followed, friends or suggested.
      # @return [Hashie::Mash] The lists a venue appears on.
      # @requies_acting_user Yes
      # @see https://developer.foursquare.com/docs/venues/listed.html
      def venue_listed(id, options = {})
        get("venues/#{id}/listed", options).lists
      end
      
      # Allows a user to mark a venue to-do, with optional text.
      #
      # @deprecated
      # @param id The venue you want to mark to-do.
      # @param options [Hash] A customizable set of options.
      # @option options [String] text The text of the tip.
      # @return [Hashie::Mash] The newly-added to-do, which contains a tip created implicitly.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/venues/marktodo.html
      def venue_marktodo(id, options = {})
        post("venues/#{id}/marktodo").todo
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
      def venue_photos(id, group = 'checkin', options = {})
        get("venues/#{id}/photos", {:group => group }.merge(options)).photos
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
      # @option options [Integer] radius Limit results to venues within this many meters of the specified location.
      # @option options [Decimal] sw With ne, limits results to the bounding quadrangle defined by the latitude and longitude given by sw as its south-west corner, and ne as its north-east corner.
      # @option options [Decimal] ne See sw 
      # @option options [String] categoryId A category to limit the results to. (experimental)
      # @option options [String] url A third-party URL which is attempted to match against a map of venues to URLs. (experimental)
      # @option options [String] providerId Identifier for a known third party that is part of a map of venues to URLs, used in conjunction with linkedId. (experimental)
      # @option options [Integer] linkedId Identifier used by third party specified in providerId, which will be attempted to match against a map of venues to URLs. (experimental)
      # @return [Hashie::Mash] An array of objects representing groups of venues.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/venues/search.html 
      def venue_search(ll, options = {})
        get('venues/search', { :ll => ll }.merge(options)).venues
      end
      
      # Get venue stats over a given time range.
      #
      # @param ids [String] The venue id to retrieve stats for.
      # @param options [Hash] A customizable set of options.
      # @options option [Integer] startAt The start of the time range to retrieve stats for (seconds since epoch). If omitted, all-time stats will be returned.
      # @options option [Integer] endAt The end of the time range to retrieve stats for (seconds since epoch). If omitted, the current time is assumed.
      # @return [Hashie::Mash] A venue stats object.
      # @require_acting_user Yes
      # @see https://developer.foursquare.com/docs/venues/stats
      def venue_stats(id, options = {})
        get("venues/#{id}/stats", options)
      end
      
      # Returns a list of mini-venues matching the search term, near the location.
      #
      # @note This is an experimental API.
      # @param ll [String] Latitude and longitude of the user's location. (Required for query searches)
      # @param query [String] A search term to be applied against titles. Must be at least 3 characters long.
      # @param options [Hash] A customizable set of options.
      # @option options [Decimal] llAcc Accuracy of latitude and longitude, in meters. (Does not currently affect search results)
      # @option options [Decimal] alt Altitude of the user's location, in meters. (Does not currently affect search results.)
      # @option options [Decimal] altAcc Accuracy of the user's altitude, in meters. (Does not currently affect search results.)
      # @option options [Integer] limit Number of results to return, up to 100.
      # @return [Hashie::Mash] An array of venue objects.
      # @require_acting_user No
      # @see https://developer.foursquare.com/docs/venues/suggestcompletion 
      def venue_suggestcompletion(ll, query, options = {})
        get('venues/suggestcompletion', { :ll => ll, :query => query }.merge(options)).minivenues
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
