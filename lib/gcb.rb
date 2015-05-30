require 'gcb/version'

module Gcb
  def self.root
    File.expand_path '../..', __FILE__
  end

  class BranchChanger
    def initialize(git_repository_directory=Dir.pwd)
      @git_dir = "#{git_repository_directory}/.git"
    end

    def change!(branch)
      if branches.include?(branch)
        checkout_branch(branch)
      elsif partially_matching_branch = partially_matching_branch_from_branches_and_branch(branches, branch)
        checkout_branch(partially_matching_branch)
      else
        # don't change branch
      end
      current_branch
    end

  private

    #
    # Matching
    #
    def partially_matching_branch_from_branches_and_branch(branches, branch)
      branches.find { |existing_branch| existing_branch.include?(branch) }
    end


    #
    # Git Queries
    #
    def branches
      @branches ||= git('branch').split("\n").map { |branch| branch.gsub('*', '') }.map(&:strip)
    end

    def current_branch
      git('branch').match(/\* (.*)\n/)[1]
    end

    def checkout_branch(branch)
      git("checkout #{branch}")
    end

    def git(command)
      `git --git-dir=#{@git_dir} #{command}`
    end
  end
end
