class Capistrano::Notifier::Base
  def initialize()
  end

  private

  def application
    fetch :application
  end

  def branch
    fetch :branch
  end

  def git_current_revision
    fetch(:current_revision).try(:[], 0,7)
  end

  def git_log
    return unless git_range

    #`git log #{git_range} --no-color --pretty=format:'%an: %s (%h)' --abbrev-commit --no-merges --encoding=utf-8`
    `git log b00bfbc..20e0280 --no-color --pretty=format:'%an: %s (%h)' --abbrev-commit --no-merges --encoding=utf-8`
  end

  def git_previous_revision
    fetch(:previous_revision).try(:[], 0,7)
  end

  def git_range
    return unless git_previous_revision && git_current_revision

    "#{git_previous_revision}..#{git_current_revision}"
  end

  def now
    @now ||= Time.now
  end

  def stage
    fetch :stage
  end

  def user_name
    user = ENV['DEPLOYER']
    user = `git config --get user.name`.strip if user.nil?
  end
end
