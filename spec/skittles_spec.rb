require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Skittles" do
  before do
    Skittles.configure do |config|
      config.client_id     = ''
      config.client_secret = ''
      config.access_token  = ''    
    end
  end

  it "should search for venues" do
    response = Skittles.venue_search "40.7,-74", query: "Brooklyn Bridge Park - Pier 1"

    response.should_not be_nil
    response.venues.count.should == 1
    response.venues.first.name.should == "Brooklyn Bridge Park - Pier 1" 
  end
end
