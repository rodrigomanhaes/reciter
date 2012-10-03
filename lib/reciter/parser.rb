module Reciter
  class Parser
    def parse(sequence)
      sequence.split(';').map(&:to_i).sort
    end
  end
end
