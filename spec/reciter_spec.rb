require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Reciter::Parser do
  describe 'to list' do
    it 'parses single numbers' do
      subject.parse('1').should == [1]
      subject.parse('50').should == [50]
      subject.parse('987654').should == [987654]
    end

    it 'parses semicolon-separated list of numbers' do
      subject.parse('1;2;3').should == [1, 2, 3]
      subject.parse('9;987;1;6542').should == [1, 9, 987, 6542]
    end
  end
end
