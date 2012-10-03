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
      ranges = []
      last = nil
      sequence.sort.each do |n|
        if last.nil? || n != last + 1
          ranges << Range.new(n, n)
        else
          ranges[-1] = Range.new(ranges[-1].begin, n)
        end
        last = n
      end
      ranges.map {|r|
        r.begin == r.end ?
          r.begin :
          "%s to %s" % [r.begin, r.end]
      }.
      join(', ')
    end

    private

    def validate(sequence)
      subsequences = sequence.split(';')
      raise InvalidInput unless !subsequences.empty? &&
        subsequences.all? {|subsequence| subsequence =~ /^(\d+\-\d+)$|^\d+$/ }
    end
  end
end
