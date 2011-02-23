require 'uri'
require 'net/http/post/multipart'

module Skittles
  class Client
    # Define methods related to photos.
    # @see http://developer.foursquare.com/docs/photos/photos.html
    module Photo
      # Get details of a photo.
      #
      # @param id [String] The id of the photo to retrieve additional information for.
      # @return A complete photo object.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/photos/photos.html
      def photo(id)
        get("photos/#{id}").photo
      end
      
      # Allows users to add a new photo to a checkin, tip, or a venue in
      # general.
      #
      # @param file [String] Path to the file to upload.
      # @param options [Hash] A customizable set of options.
      # @option options [String] checkinId The id of a checkin owned by the user.
      # @option options [String] tipId The ID of a tip owned by the user.
      # @option options [String] venueId The ID of a venue, provided only when adding a public photo of the venue in general, rather than a private checkin or tip photo using the parameters above.
      # @option options [String] broadcast Whether to broadcast this photo to twitter, facebook or both.
      # @option options [String] ll Latitude and longitude of the user's location.
      # @option options [Decimal] llAcc Accuracy of the user's latitude and longitude, in meters.
      # @option options [Decimal] alt Altitude of the user's location, in meters.
      # @option options [Decimal] altAcc Vertical accuracy of the user's location, in meters.
      # @return The photo that was just created.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/photos/add.html
      def add_photo(file, options = {})
        resp = nil
        options.merge!({
          :file => UploadIO.new(file, 'image/jpeg', 'image.jpg'),
          :oauth_token => access_token
        })
        uri = URI.parse("#{endpoint}/photos/add")
        File.open(file) do |file|
          req = Net::HTTP::Post::Multipart.new(uri.path, options)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == 'https'
          resp = http.start do |http|
            http.request(req)
          end
        end
        case resp.code.to_i
        when 200..299
          return Hashie::Mash.new(Yajl::Parser.new.parse(resp.body)).response.photo
        when 401
          e = OAuth2::AccessDenied.new("Received HTTP 401 during request.")
          e.response = resp
          raise e
        else
          e = OAuth2::HTTPError.new("Received HTTP #{resp.code} during request.")
          e.response = resp
          raise e
        end
      end
    end
  end
end