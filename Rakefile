require "bundler/gem_tasks"
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

task :irb do
  require 'irb'
  require 'awesome_print'
  require 'irb/completion'
  require 'code_lister'
  include CodeLister
  ARGV.clear
  IRB.start
end

task :pry do
  require 'pry'
  require 'awesome_print'
  require 'code_lister'
  include CodeLister
  ARGV.clear
  Pry.start
end
