require "gcb/version"

module Gcb
  class Parser
    def initialize(input)

    end

    def execute!
      `git branch`
    end
  end
end
