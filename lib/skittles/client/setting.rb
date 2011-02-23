module Skittles
  class Client
    # Define methods related to settings.
    # @see http://developer.foursquare.com/docs/settings/settings.html
    module Setting
      # Returns all settings of the active user.
      #
      # @return [Hashie::Mash] A setting object for the acting user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/settings/all.html
      def all_settings
        get('settings/all').settings
      end
      
      # Change a setting for the given user.
      #
      # @param id [String] Name of setting to change, sendToTwitter, sendToFacebook, receivePings, receiveCommentPings.
      # @param value [Integer] 1 for true, and 0 for false.
      # @requires_acting_user Yes
      # @return [Hashie::Mash] A confirmation message.
      # @see http://developer.foursquare.com/docs/settings/set.html
      def set_setting(id, value)
        post("settings/#{id}/set", { :value => value }).settings
      end
      
      # Returns a setting for the acting user.
      #
      # @param id [String] The name of a setting.
      # @return [Hashie::Mash] The value for this setting for the acting user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/settings/settings.html
      def setting(id)
        get("settings/#{id}").value
      end
    end
  end
end