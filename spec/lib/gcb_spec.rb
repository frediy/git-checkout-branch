require 'spec_helper'

module Gcb
  describe BranchChanger do
    GIT_TEST_REPO_DIRECTORY = "#{Gcb.root}/spec/fixtures/git_test_repo"

    let (:branch_changer) { BranchChanger.new(GIT_TEST_REPO_DIRECTORY) }

    let (:branches) { ['master'] }

    before do
      initialize_repo
      add_branches(branches)
    end

    after do
      FileUtils.rm_rf(GIT_TEST_REPO_DIRECTORY)
    end

    describe "#change!" do
      let (:branches) { ['master'] }
      let (:input) { 'master' }

      before do
        branch_changer.change!(input)
      end


      describe 'switch to exact branch name' do
        let (:branches) { ['master', 'new-branch'] }

        let (:input) { 'new-branch' }
        let (:expected_branch) { 'new-branch' }

        specify { expect(current_branch).to eq expected_branch }
      end

      describe 'switch to partial branch name' do
        let (:branches) { ['master', 'new-branch'] }

        let (:input) { 'new' }
        let (:expected_branch) { 'new-branch' }

        specify { expect(current_branch).to eq expected_branch }
      end
    end

    def initialize_repo
      `git init #{GIT_TEST_REPO_DIRECTORY}`
      `touch #{GIT_TEST_REPO_DIRECTORY}/file`
      git("add #{GIT_TEST_REPO_DIRECTORY}")
      git("commit -m 'initial'")
    end

    def add_branches(branches)
      branches.each do |branch|
        next if branch == 'master'
        add_branch(branch)
      end
    end

    def add_branch(branch_name)
      previous_branch = current_branch
      git("checkout -b #{branch_name}")
      git("checkout #{previous_branch}")
    end

    def current_branch
      git('branch').match(/\* (.*)\n/)[1]
    end

    def git(command)
      `git --git-dir=#{GIT_TEST_REPO_DIRECTORY}/.git #{command}`
    end
  end
end