module Reciter
  class Parser
    def parse(sequence)
      validate(sequence)
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

    def unparse(*sequence)
      sequence.join(', ')
    end

    private

    def validate(sequence)
      subsequences = sequence.split(';')
      raise InvalidInput unless !subsequences.empty? &&
        subsequences.all? {|subsequence| subsequence =~ /^(\d+\-\d+)$|^\d+$/ }
    end
  end
end
