#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-

require 'date'

# Load this library's version information
require File.expand_path('../lib/merb_datamapper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'merb_datamapper'
  gem.version     = Merb::DataMapper::VERSION.dup
  gem.date        = Date.today.to_s
  gem.authors     = [ "Jason Toy", "Jonathan Stott" ]
  gem.email       = "jonathan.stott@gmail.com"
  gem.homepage    = "http://github.com/merb/merb_datamapper"
  gem.description = "Merb plugin that provides support for datamapper"
  gem.summary     = "Merb plugin that allows you to use datamapper with your merb app"

  gem.has_yardoc    = true
  gem.require_paths = ['lib']
  gem.files = Dir[
    'Generators',
    'Rakefile',
    '{lib,spec}/**/*',
    'README*',
    'LICENSE*',
    'TODO*'
  ] & `git ls-files -z`.split("\0")

  # Runtime dependencies
  gem.add_dependency 'merb-core',     "~> 1.1"
  gem.add_dependency 'dm-core',       Merb::DataMapper::DM_VERSION_REQUIREMENT
  gem.add_dependency 'dm-migrations', Merb::DataMapper::DM_VERSION_REQUIREMENT

  # Development dependencies
  gem.add_development_dependency 'rspec', '>= 1.2.9'
end
