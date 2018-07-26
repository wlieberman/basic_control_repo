require 'puppetlabs_spec_helper/rake_tasks'
require 'ci/reporter/rake/rspec'
require 'yamllint/rake_task'
require 'rubocop-rspec'

begin
  if Gem::Specification::find_by_name('puppet-lint')
    require 'puppet-lint/tasks/puppet-lint'
    PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
    task :default => [:rspec, :lint]

  end
rescue Gem::LoadError
  task :default => :rspec
end

YamlLint::RakeTask.new do |t|
  t.paths = %w(
    spec/**/*.yaml,
    hieradata/**/*.yaml
  )
end

RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-rspec'
end

task :spec => 'ci:setup:rspec'
