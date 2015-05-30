require 'spec_helper'

module Gcb
  describe Parser do
    let (:parser) { Parser.new(input) }
    let (:input) { '' }

    subject { parser.execute! }

    it { is_expected.to eq false }
  end
end