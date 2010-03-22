require 'rubygems'
require 'rake'

# Assume a typical dev checkout to fetch the current merb-core version
require File.expand_path('../../merb/merb-core/lib/merb-core/version', __FILE__)

# Load this library's version information
require File.expand_path('../lib/merb_datamapper/version', __FILE__)

begin

  gem 'jeweler', '~> 1.4'
  require 'jeweler'

  Jeweler::Tasks.new do |gemspec|

    gemspec.version     = Merb::DataMapper::VERSION.dup

    gemspec.name        = "merb_datamapper"
    gemspec.description = "Merb plugin that provides support for datamapper"
    gemspec.summary     = "Merb plugin that allows you to use datamapper with your merb app"

    gemspec.authors     = [ "Jason Toy" ]
    gemspec.email       = "jtoy@rubynow.com"
    gemspec.homepage    = "http://github.com/merb/merb_datamapper"

    gemspec.files       = %w(Generators LICENSE Rakefile README TODO) + Dir['{lib,spec}/**/*']

    # Runtime dependencies
    gemspec.add_dependency 'merb-core',     "~> #{Merb::VERSION}"
    gemspec.add_dependency 'dm-core',       Merb::DataMapper::DM_VERSION_REQUIREMENT
    gemspec.add_dependency 'dm-migrations', Merb::DataMapper::DM_VERSION_REQUIREMENT

    # Development dependencies
    gemspec.add_development_dependency 'rspec', '>= 1.2.9'

  end

  Jeweler::GemcutterTasks.new

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.spec_opts << '--options' << 'spec/spec.opts' if File.exists?('spec/spec.opts')
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

desc 'Default: run spec examples'
task :default => 'spec'
