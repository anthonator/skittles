module Skittles
  class Client
    # Define methods related to lists.
    # @see https://developer.foursquare.com/docs/lists/lists.html
    module List
      def add_list(name, options = {})
        post("lists/add", { :name => name }.merge(options)).list
      end
      
      # Gives detail about a list.
      #
      # @param id [String] The id of the list to retrieve additional information for.
      # @return [Hashie::Mash] A list object.
      # @requires_acting_user No
      # @see https://developer.foursquare.com/docs/lists/lists.html
      def list(id)
        get("lists/#{id}").list
      end
      
      # Returns users following this list.
      #
      # @note Only valid on user-created lists.
      # @param id [String] The id of the user created list to retrieve additional information for.
      # @return [Hashie::Mash] A pageable list of compact user.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/lists/followers.html
      def list_followers(id)
        get("lists/#{id}/followers").followers
      end
      
      # Suggests venues that may be appropriate for this list.
      #
      # @note Only valid on user-created lists.
      # @param id [String] The id of the user created list to retrieve additional information for.
      # @return [Hashie::Mash] An array of compact venues.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/lists/suggestvenues.html
      def list_suggestvenues(id)
        get("lists/#{id}/suggestvenues").suggestedVenues
      end
      
      # Suggests photos that may be appropriate for this item.
      #
      # @note Only valid on user-created lists.
      # @param list_id [String] The id of the user created list to retrieve additional information for.
      # @param item_id [String] The id of the item to retrieve for a list.
      # @return [Hashie::Mash] Returns groups user and others containing lists of photos.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/lists/suggestphoto.html
      def list_suggestphoto(list_id, item_id)
        get("lists/#{list_id}/suggestphoto", { :item_id => item_id }).photos
      end
      
      # Suggests tips that may be appropriate for this item.
      #
      # @note Only valid on user-created lists.
      # @param list_id [String] The id of the user created list to retrieve additional information for.
      # @param item_id [String] The id of the item to retrieve for a list.
      # @return [Hashie::Mash] Returns groups user and others containing lists of photos.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/lists/suggesttip.html 
      def list_suggesttip(list_id, item_id)
        get("lists/#{list_id}/suggesttip", { :item_id => item_id }).tips
      end
    end
  end
end