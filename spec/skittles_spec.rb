require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Skittles do  
  describe :user do
    describe :mayorships do
      it 'should return a count and array of items' do
        response = Skittles.mayorships
        response.count.should be_a_kind_of Integer
        response.items.should be_a_kind_of Array
      end
      
    end
    
    describe :update do
      it 'should return a JSON response of the current user' do
        #response = Skittles.update_user_photo('spec/ruby.jpeg')
        #response.type.should == 'user'
      end
    end
    
    describe :user_lists do
      it 'should return a groups array' do
        response = Skittles.user_lists
        response.count.should be_a_kind_of Integer
        response.groups.should be_a_kind_of Array
      end
      
      it 'should return count and items of lists' do
        response = Skittles.user_lists('self', { :group => :created })
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
      
      describe :herenow do
        it 'should return a list of users who are at the current location' do
          response = Skittles.herenow('235908')
          response.count.should be_a_kind_of Integer
          response.items.should be_a_kind_of Array
        end
      end
    end
    
    describe :venue_events do
      it 'should return a list of events' do
        response = Skittles.venue_events('4ad90170f964a5200b1721e3')
        response.count.should be_a_kind_of Integer
        response.items.should be_a_kind_of Array
      end
    end
    
    describe :venue_listed do
      it 'should return a count and groups array' do
        response = Skittles.venue_listed('4ad90170f964a5200b1721e3')
        response.count.should be_a_kind_of Integer
        response.groups.should be_a_kind_of Array
      end
      
      it 'should return a count and items array' do
        response = Skittles.venue_listed('4ad90170f964a5200b1721e3', { :group => :created })
        response.count.should be_a_kind_of Integer
        response.items.should be_a_kind_of Array
      end
    end
    
    describe :venue_suggestcompletion do
      it 'should return an array of venues' do
        response = Skittles.venue_suggestcompletion('39.7720648060275,-86.15538597106934', 'the terminator')[0]
        response.id.should be_a_kind_of String
      end
    end
  end
  
  describe :tip do
    describe :tip_listed do
      it 'should return a count and groups array' do
        response = Skittles.tip_listed('4e90aa70722ebb868bcc7efe')
        response.count.should be_a_kind_of Integer
        response.groups.should be_a_kind_of Array
      end
      
      it 'should return a count and items array' do
        response = Skittles.tip_listed('4e90aa70722ebb868bcc7efe', { :group => :created })
        response.count.should be_a_kind_of Integer
        response.items.should be_a_kind_of Array
      end
    end
  end
  
  describe :list do
    before(:each) do
      @list = Skittles.add_list('A list created by Skittles')
    end

    it 'should return a list object' do
      response = Skittles.list(@list.id)
      response.should_not be_nil
    end
    
    describe :add_list do
      it 'should create a list' do
        response = Skittles.add_list('A list created by Skittles')
        response.should_not be_nil
      end
    end
    
    describe :list_followers do
      it 'should return a list of followers' do
        response = Skittles.list_followers(@list.id)
        response.should_not be_nil
      end
    end
    
    describe :list_suggestvenues do
      it 'should return an array of venues' do
        response = Skittles.list_suggestvenues(@list.id)
        response.should be_kind_of Array
      end
    end
    
    describe :list_suggestphoto do
      it 'should return groups user and others' do
        # todo
      end
    end
  end
  
  describe :event do
    it 'should return an event object' do
      # can't find an event id
    end
    
    describe :event_search do
      it 'should return an array of events' do
        response = Skittles.event_search('songkick.com', '8183976')
        response.should_not be_nil
      end
    end
    
    describe :event_categories do
      it 'should return an array of categories' do
        response = Skittles.event_categories
        response.should be_kind_of Array
      end
    end
  end
end
