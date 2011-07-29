module Skittles
  class Client
    # Define methods related to specials.
    # @see http://developer.foursquare.com/docs/specials/specials.html
    module Special
      # Allows users to indicate a special is improper in some way.
      #
      # @params special_id [String] The id of the special being flagged.
      # @param venue_id [String] The id of the venue running the special.
      # @param problem [String] One of not_redeemable, not_valuable, other.
      # @param options [Hash] A customizable set of options.
      # @option options [String] text Additional text about why the user has flagged this special.
      # @require_acting_user Yes
      # @see https://developer.foursquare.com/docs/specials/flag.html
      def flag_special(special_id, venue_id, problem, options = {})
        post("specials/#{special_id}/flag", { :venueId => venue_id, :problem => problem }.merge(options))
        nil
      end
      
      # Gives details about a special, including text and unlock rules.
      #
      # @param special_id [String] Id of special to retrieve.
      # @return [Hashie::Mash] A complete special.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/specials/specials.html
      def special(special_id, venue_id)
        get("specials/#{special_id}", :venueId => venue_id).special
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
        get('specials/search', { :ll => ll }.merge(options)).specials
      end
    end
  end
end