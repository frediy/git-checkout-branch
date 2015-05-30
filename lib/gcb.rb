require 'gcb/version'

module Gcb
  class BranchChanger
    def initialize(input, git_repo_dir=Dir.pwd)
       @git_repo_dir = git_repo_dir
    end

    def execute!
      branches
    end

  private

    def branches
      @branches ||= git('branch').split("\n").map { |branch| branch.gsub('*', '') }.map(&:strip)
    end

    def git(command)
      `git --git-dir=#{@git_repo_dir}/.git #{command}`
    end
  end
end
