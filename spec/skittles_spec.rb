require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Skittles" do
  it 'should search for venues' do
    response = Skittles.venue_search('40.7,-75', :query => 'Brooklyn Bridge Park - Pier 1')
    response.should_not be_nil
    response.should be_a_kind_of Array
  end
end
