require 'spec_helper'

module Gcb
  describe BranchChanger do
    let (:parser) { BranchChanger.new(input) }
    let (:input) { '' }

    subject { parser.change! }

    let (:git_test_repo_directory) { './spec/fixtures/git_test_repo' }

    before do
      initialize_git_repo(git_test_repo_directory)
    end

    it { is_expected.to eq false }

    def initialize_git_repo(dir)
      `git init #{dir}`
    end
  end
end