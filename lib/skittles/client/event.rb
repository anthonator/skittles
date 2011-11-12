module Skittles
  class Client
    # Define methods related to events.
    # @see https://developer.foursquare.com/docs/events/events.html
    module Event
      # Get details of an event.
      #
      # @param id The id of the event to retrieve additional information for.
      # @return [Hashie::Mash] An event object.
      # @require_acting_user Yes
      # @see https://developer.foursquare.com/docs/events/events.html
      def event(id)
        get("events/#{id}").event
      end
      
      # Get a list of events matching the search parameters.
      #
      # @note This is an experimental API.
      # @param domain Identifier for a known third-party event provider.
      # @param id Identifier used by third-party.
      # @return [Hashie::Mash] An array of event objects.
      # @require_acting_user No
      # @see https://developer.foursquare.com/docs/events/search.html
      def event_search(domain, id)
        get('events/search', { :domain => domain, :id => id }).event
      end
      
      # Get a hierachical list of categoires applied to events.
      #
      # @return [Hashie::Mash] An array of categories.
      # @require_acting_user No
      # @see https://developer.foursquare.com/docs/events/categories.html
      def event_categories
        get('events/categories').categories
      end
    end
  end
end