module Skittles
  class Client
    # Define methods related to specials.
    # @see http://developer.foursquare.com/docs/specials/specials.html
    module Special
      # Gives details about a special, including text and unlock rules.
      #
      # @param id [String] Id of special to retrieve.
      # @return [Hashie::Mash] A complete special.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/specials/specials.html
      def special(id)
        get("specials/#{id}")
      end
      
      # Returns a list of specials near the current location.
      #
      # @note This is an experimental API.
      # @param ll [String] Latitude and longitude to search near.
      # @param options [Hash] A customizable set of options.
      # @option options [Decimal] llAcc Accuracy of latitude and longitude, in meters.
      # @option options [Decimal] alt Altitude of the user's location, in meters.
      # @option options [Decimal] altAcc Accuracy of the user's altitude, in meters.
      # @option options [Integer] limit Number of results to return, up to 50.
      # @return [Hashie::Mash] An array of specials being run at nearby venues.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/specials/search.html
      def special_search(ll, options = {})
        get('specials/search', { :ll => ll }.merge(options))
      end
    end
  end
end