require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Reciter::Parser do
  describe 'to list' do
    it 'parses single numbers' do
      subject.parse('1').should == [1]
      subject.parse('50').should == [50]
      subject.parse('987654').should == [987654]
    end
  end
end
