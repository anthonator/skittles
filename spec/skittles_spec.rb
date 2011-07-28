require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Skittles" do
  describe :user do
    describe :mayorships do
      it 'should return a count and array of items' do
        response = Skittles.mayorships
        response.count.should be_a_kind_of Integer
        response.items.should be_a_kind_of Array
      end
    end
  end
  
  describe :venue do
    describe :venue_search do
      it 'should return an array of values' do
        response = Skittles.venue_search('40.7,-75', :query => 'Brooklyn Bridge Park - Pier 1')
        response.should_not be_nil
        response.should be_a_kind_of Array
      end
    end
  end
end
