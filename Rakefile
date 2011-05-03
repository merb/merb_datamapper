require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require File.expand_path("../lib/merb_datamapper/version", __FILE__)

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
  spec.fail_on_error = false
  spec.rcov = true
end

desc "Build project gem"
task :build do
  sh "#{RUBY} -S gem build merb_datamapper.gemspec"
end

desc "Build and install gem"
task :install => :build do
  sh "#{RUBY} -S gem install -l ./merb_datamapper-#{Merb::DataMapper::VERSION}.gem --no-rdoc --no-ri"
end

desc 'Default: run spec examples'
task :default => 'spec'
