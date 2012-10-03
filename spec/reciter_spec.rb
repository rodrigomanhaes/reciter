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

    it 'parses intervals' do
      subject.parse('2-5').should == [2, 3, 4, 5]
      subject.parse('1-1000').should == (1..1000).to_a
    end

    it 'parses both intervals and semicolon-separated numbers' do
      subject.parse('1-3;4-5;8;10-12;15;18').should ==
        [1, 2, 3, 4, 5, 8, 10, 11, 12, 15, 18]
    end

    it 'discards repeated numbers' do
      subject.parse('1;1').should == [1]
      subject.parse('1-3;2-5').should == [1, 2, 3, 4, 5]
    end
  end
end
