require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "bundler"
Bundler.setup

gemspec = eval(File.read("handy_apn.gemspec"))

require "handy_apn/rakefile"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
