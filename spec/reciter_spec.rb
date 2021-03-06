require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Reciter::Parser do
  describe 'parsing' do
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

    it 'raises error for invalid input' do
      expect { subject.parse('a') }.to raise_error Reciter::InvalidInput
      expect { subject.parse(';') }.to raise_error Reciter::InvalidInput
      expect { subject.parse('-') }.to raise_error Reciter::InvalidInput
      expect { subject.parse('1-a') }.to raise_error Reciter::InvalidInput
      expect { subject.parse('2;a;4') }.to raise_error Reciter::InvalidInput
      expect { subject.parse('e-4') }.to raise_error Reciter::InvalidInput
      expect { subject.parse('2.') }.to raise_error Reciter::InvalidInput
      expect { subject.parse('1-3-5') }.to raise_error Reciter::InvalidInput
      expect { subject.parse('9-7') }.to raise_error Reciter::InvalidInput
    end

    it 'returns an empty array for blank inputs' do
      subject.parse('').should be_empty
      subject.parse(nil).should be_empty
    end
  end

  describe 'unparsing' do
    it 'sparse list' do
      subject.unparse(:mechanic, 1, 3, 5, 7, 9).should == '1;3;5;7;9'
      subject.unparse(1, 3, 5, 7, 9).should == '1, 3, 5, 7, 9'
    end

    it 'intervals' do
      subject.unparse(:mechanic, 1, 2, 3, 4, 5).should == '1-5'
      subject.unparse(1, 2, 3, 4, 5).should == '1 to 5'
    end

    it 'handles two-numbers interval like sparse values' do
      subject.unparse(:mechanic, 4, 5).should == '4;5'
      subject.unparse(4, 5).should == '4, 5'
    end

    it 'intervals and sparse' do
      subject.unparse(:mechanic, 1, 3, 4, 5, 7, 9, 10, 12, 18, 19, 20).should == \
        '1;3-5;7;9;10;12;18-20'
      subject.unparse(1, 3, 4, 5, 7, 9, 10, 12, 18, 19, 20).should == \
        '1, 3 to 5, 7, 9, 10, 12, 18 to 20'
    end

    it 'allows definition of alternative text for "to"' do
      Reciter::Parser.config.text_for_to = 'a' # portuguese
      subject.unparse(1, 2, 3).should == '1 a 3'
    end

    it 'allows array as argument' do
      subject.unparse([1, 2, 3]).should == '1 a 3'
      subject.unparse(:mechanic, [1, 2, 3]).should == '1-3'
    end
  end
end
