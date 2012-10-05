module Skittles
  class Client
    # Define methods related to tips.
    # @see http://developer.foursquare.com/docs/tips/tips.html
    module Tip
      # Allows a user to add a new tip at a venue.
      #
      # @param id [String] The venue where you want to add this tip.
      # @param text [String] The text of the tip.
      # @param options [Hash] A customizable set of options.
      # @option options [String] url A URL related to this tip.
      # @return [Hashie::Mash] The newly-added tip.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/tips/add.html
      def add_tip(id, text, options = {})
        post("tips/add", {
          :venueId => id,
          :text => text
        }.merge(options)).tip
      end

      # Returns an array of users who have done a tip.
      #
      # @param [String] id The tip to retrieve users who have done this tip for.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 200.
      # @option options [Integer] offset Used to page through results.
      # @return A count and items of compact user objects.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/tips/done
      def done_tip(id, options = {})
        get("tips/#{id}/done", options).users
      end

      # Allows a user to like or unlike a tip.
      #
      # @param id The tip to like or unlike.
      # @param set if 1, like this tip. If 0 unlike. Default value is 1.
      # @return [Hashie::Mash] Updated count and groups of users who like this tip.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/tips/like
      def like_tip(id, set = 1)
        post("tips/#{id}/like", { :set => set }).likes
      end
      
      # Gives details about a tip, including which users (especially friends)
      # have marked the tip to-do or done.
      #
      # @param id [String] Id of the tip to retrieve.
      # @return [Hashie::Mash] A complete tip.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/tips/tips.html
      def tip(id)
        get("tips/#{id}").tip
      end
      
      # Returns friends and a total count of users who have liked this tip.
      #
      # @param id [String] The tip to return likes for.
      # @return [Hashie::Mash] A count of groups of users who like this tip.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/tips/likes
      def tip_likes(id)
        get("tips/#{id}/likes").likes
      end

      # The lists that a tip appears on.
      #
      # @param id [String] The tip to get lists for.
      # @param options [Hash] A customizable set of options.
      # @option options [String] group Either created, edited, followed, friends or suggested.
      # @return The lists a tip appears on.
      # @require_acting_user Yes
      # @see https://developer.foursquare.com/docs/tips/listed.html
      def tip_listed(id, options = {})
        get("tips/#{id}/listed", options).lists
      end
      
      # Allows the acting user to mark a tip done.
      #
      # @deprecated
      # @param id [String] The tip you want to mark done.
      # @return [Hashie::Mash] The marked to-do.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/tips/markdone.html
      def tip_markdone(id)
        post("tips/#{id}/markdone").todo
      end
      
      # Allows you to mark a tip to-do.
      #
      # @deprecated
      # @param id [String] The tip you want to mark to-do.
      # @return [Hashie::Mash] The newly-added to-do.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/tips/marktodo.html
      def tip_marktodo(id)
        post("tips/#{id}/marktodo").todo
      end
      
      # Returns a list of tips near the area specified. 
      #
      # @param ll [String] Latitude and longitude of the user's location.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 500.
      # @option options [Integer] offset Used to page through results.
      # @option options [String] filter If set to friends, only show nearby tips from friends.
      # @option options [String] query Only find tips matching the given term, cannot be used in conjunction with friends filter.
      # @return [Hashie::Mash] An array of tips, each of which contain a user and venue.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/tips/search.html
      def tip_search(ll, options = {})
        get("tips/search", { :ll => ll }.merge(options)).tips
      end
      
      # Allows you to remove a tip from your to-do list or done list.
      #
      # @deprecated
      # @param id [String] The tip you want to unmark.
      # @return [Hashie::Mash] The tip being acted on.
      # @requires_acting_user No
      # @see http://developer.foursquare.com/docs/tips/unmark.html
      def tip_unmark(id)
        post("tips/#{id}/unmark").tip
      end
    end
  end
end
