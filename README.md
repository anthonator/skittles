# Skittles [![endorse](http://api.coderwall.com/anthonator/endorsecount.png)](http://coderwall.com/anthonator)

A Ruby implementation of the Foursquare v2 REST API.

## Documentation

You can view detailed documentation of this library at http://rdoc.info/github/anthonator/skittles. We try to make sure that our documentation is up-to-date and thorough. However, we do recommend keeping the [Foursquare developer documentation](https://developer.foursquare.com/docs/) handy.

If you find a discrepency in our documentation please [file an issue](https://github.com/anthonator/skittles/issues/new).

## Usage

```ruby
require 'rubygems'
  require 'skittles'
  
  Skittles.configure do |config|
    config.client_id     = '...'
    config.client_secret = '...'
    config.access_token  = '...'
  end
  
  begin
    Skittles.venue('211152')
  rescue Skittles::Error => e
    puts "You recieved the #{e.type} error and a status code of #{e.code} which means #{e.detail}."
  end
```