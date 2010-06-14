require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require File.expand_path("../lib/merb_datamapper/version", __FILE__)

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
