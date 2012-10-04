require 'mime/types'

module Skittles
  class Client
    # Define methods related to users.
    # @see http://developer.foursquare.com/docs/users/users.html
    module User
      # Approve a pending friend request from another user.
      #
      # @param id [String] The user ID of a pending friend.
      # @return [Hashie::Mash] A user object for the approved user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/approve.html
      def approve_user(id)
        post("users/#{id}/approve").user
      end
      # Returns badges for a given user.
      #
      # @param id [String] Id for user to view badges for.
      # @return [Hashie::Mash] Hierarchical groups of badge ids or, for unlocked badges, badge unlock ids, as they are intended for display.
      # @return [Hashie::Mash] A map of badge ids or badge unlock ids to a badge or a hierarchical groups of badge ids or, for unlocked badges, badge unlock ids, as they are intended for display.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/badges.html
      def badges(id)
        get("users/#{id}/badges")
      end
      
      # Returns a history of checkins for the authenticated user.
      #
      # @param id [String] For now, only "self" is supported.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 500.
      # @option options [Integer] offset Used to page through results.
      # @option options [String] sort How to sort the returned checkeins. Can be newestfirst or oldestfirst.
      # @option options [Integer] afterTimestamp Retrieve the first results to follow these seconds since epoch.
      # @option options [Integer] beforeTimestamp Retrieve the first results prior to these seconds since epoch.
      # @return [Hashie::Mash] A count of items in check-ins.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/checkins.html 
      def checkins(id = 'self', options = {})
        get("users/#{id}/checkins").checkins
      end
      
      # Denies a pending friend request from another user.
      #
      # @param id [String] The user ID of a pending friend.
      # @return [Hashie::Mash] A user object for the denied user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/deny.html
      def deny_user(id)
        post("users/#{id}/deny").user
      end
      
      # Sends a friend request to another user.
      #
      # @param id [String] The user ID to which a request will be sent.
      # @return [Hashie::Mash] A user object for the pending user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/request.html
      def friend_request(id)
        get("users/#{id}").user
      end
      
      # Shows a user the list of users with whom they have a pending friend
      # request.
      #
      # @return [Hashie::Mash] An array of compact user objects.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/requests.html
      def friend_requests
        get("users/requests").requests
      end
      
      # Returns an array of user's friends.
      #
      # @param id [String] Identity of the user to get friends of. Pass self to
      # get friends of the acting user.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 500.
      # @option options [Integer] offset Used to page through results.
      # @return [Hashie::Mash] A count and items of compact user objects.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/friends.html
      def friends(id, options = {})
        get("users/#{id}/friends").friends
      end
      
      # Returns the user's leaderboard.
      #
      # @param neightbors [Integer] Number of friends' scores to return that are adjacent to your score in ranked order. The current user's score is returned as well.
      # @return [Hashie::Mash] A count and items containing compact user objects, their respective scores, and their integer rank value relative to the current user.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/users/leaderboard.html
      def leaderboard(neighbors = nil)
        get('users/leaderboard').leaderboard
      end
      
      # A user's lists.
      #
      # @param id [String] Identity of the user to get lists for. Pass self to get lists of the acting user.
      # @param options [Hash] A customizable set of options.
      # @option options [String] group Either created, edited, followed, friends or suggested.
      # @option options[String] ll Latitude and longitude of the user's location.
      # @return [Hashie::Mash] A user's lists.
      # @requies_acting_user Yes
      # @see https://developer.foursquare.com/docs/users/lists.html
      def user_lists(id = 'self', options = {})
        get("users/#{id}/lists", options).lists
      end
      
      # Returns a user's mayorships
      #
      # @params id [String] Identity of the user to get mayorships for. Pass self to get friends of the acting user.
      # @return [Hashie::Mash] A count and items of objects which currently only contain compact venue objects.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/users/mayorships.html
      def mayorships(id = 'self')
        get("users/#{id}/mayorships").mayorships
      end

      # Returns photos from a user.
      #
      # @param id [String] Identity of the user to get photos for. Pass self to get photos of the acting user.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] limit Number of results to return, up to 500.
      # @option options [Integer] offset Used to page through results
      # @return [Hashie::Mash] A count and items of photos.
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/users/photos
      def user_photos(id = 'self', options = {})
        get("/users/#{id}/photos", options).photos
      end
      
      # Changes whether the acting user will receive pings (phone
      # notifications) when the specified user checks in. 
      #
      # @param id [String] The user ID of a friend.
      # @param value [Boolean] True of false.
      # @return [Hashie::Mash] A user object for the user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/setpings.html
      def setpings(id, value = false)
        post("users/#{id}/setpings", { :value => value }).user
      end
      
      # Returns todos from a user.
      #
      # @deprecated
      # @param id Identity of the user to get todos for. Pass self to get todos of the acting user.
      # @param sort One of recent or popular. Nearby requires geolat and geolong to be provided.
      # @param options [Hash] A customizable set of options.
      # @option options [String] ll Latitude and longitude of the user's location.
      # @return [Hashie::Mash] A count and items of todos.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/todos.html
      def todos(id, sort = 'recent', options = {})
        get("users/#{id}/todos", { :sort => sort }.merge(options)).todos
      end
      
      # Updates the user's profile photo.
      #
      # @param photo [String] Photo under 100KB in multipark MIME encoding with content type image/jpeg, image/gif, or image/png. 
      # @return [Hashie::Mash] The current user object
      # @requires_acting_user Yes
      # @see https://developer.foursquare.com/docs/users/update.html
      def update_user_photo(photo)
        mime_type = MIME::Types.type_for(photo)[0]
        params = {
          :photo => UploadIO.new(photo, mime_type.to_s, "image.#{mime_type.extensions[0]}"),
          :oauth_token => access_token
        }
        uri = URI.parse("#{endpoint}/users/self/update")
        File.open(photo) do
          req = Net::HTTP::Post::Multipart.new(uri.path, params)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == 'https'
          resp = http.start do |net|
            net.request(req)
          end
          
          case resp.code.to_i
          when 200..299
            return Skittles::Utils.parse_json(resp.body).response.user
          when 400..599
            Skittles::Utils.handle_foursquare_error(resp)
          end
        end
      end
      
      # Returns profile information for a given user, including selected badges
      # and mayorships.
      #
      # @param id [String] Identity of the user to get details for. Pass self to get details of the acting user.
      # @return [Hashie::Mash] Profile information for a given user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/users.html
      def user(id = 'self')
        get("users/#{id}").user
      end
      
      # Cancels any relationship between the acting user and the specified
      # user.
      #
      # @param id [String] Identity of the user to unfriend.
      # @return [Hashie::Mash] A user.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/unfriend.html
      def unfriend(id)
        post("users/#{id}/unfriend").user
      end
      
      # Helps a user locate friends.
      #
      # @param options [Hash] A customizable set of options.
      # @option options [String] phone A comma-delimited list of phone numbers to look for.
      # @option options [String] email A comma-delimited list of email addresses to look for.
      # @option options [String] twitter A comma-delimited list of Twitter handles to look for.
      # @option options [String] twitterSource A single Twitter handle. Results will be friends of this user who use Foursquare.
      # @option options [String] fbid A comma-delimited list of Facebook id's to look for.
      # @option options [String] name A single string to search for in users' names.
      # @return [Hashie::Mash] An array of compact user objects with Twitter or Facebook information and friend status.
      # @requires_acing_user Yes
      # @see http://developer.foursquare.com/docs/users/search.html
      def user_search(options = {})
        get('users/search', options)
      end
      
      # Returns tips from a user.
      #
      # @deprecated
      # @param id [String] Identity of the user to get tips from. Pass self to get tips of the acting user.
      # @option options [Hash] A customizable set of options.
      # @option options [String] sort One of recent, nearby, or popular. Nearby requires geolat and geolong to be provided.
      # @option options [String] ll Latitude and longitude of the user's location.
      # @option options [String] limit Number of results to return, up to 500.
      # @option options [String] offset Used to page through results.
      # @return [Hashie::Mash] A count and items of tips.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/tips.html
      def user_tips(id, options = {})
        get("users/#{id}/tips").tips
      end
      
      # Returns a list of all venues visited by the specified user, along with
      # how many visits and when they were last there.
      #
      # @note This is an experimental API.
      # @param id [String] For now, only "self" is supported.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] beforeTimestamp Seconds since epoch.
      # @option options [Integer] Seconds after epoch.
      # @return [Hashie::Mash] A count and items of objects containing a beenHere count, lastHereAt timestamp, and venue compact venues.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/users/venuehistory.html
      def venuehistory(id = 'self', options = {})
        get("users/#{id}/venuehistory", options).venues
      end
    end
  end
end
