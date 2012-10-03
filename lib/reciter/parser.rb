module Reciter
  class Parser
    def parse(sequence)
      sequence.
      split(';').
      map {|subsequence|
        subsequence.include?('-') ?
          Range.new(*subsequence.split('-').map(&:to_i)).to_a :
          subsequence
      }.
      flatten.
      uniq.
      map(&:to_i).
      sort
    end
  end
end
