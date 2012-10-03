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
        if r.end == r.begin || r.end == r.begin + 1
          r.to_a
        else
          "%s %s %s" % [r.begin, config.text_for_to, r.end]
        end
      }.
      flatten.
      join(', ')
    end

    def self.config
      @config ||= Reciter::Config.new
    end

    private

    def validate(sequence)
      subsequences = sequence.split(';')
      raise InvalidInput unless !subsequences.empty? &&
        subsequences.all? {|subsequence| subsequence =~ /^(\d+\-\d+)$|^\d+$/ }
    end

    def config
      self.class.config
    end
  end
end
