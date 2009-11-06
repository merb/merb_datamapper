require "rubygems"

# Use current merb-core sources if running from a typical dev checkout.
lib = File.expand_path('../../../merb/merb-core/lib', __FILE__)
$LOAD_PATH.unshift(lib) if File.directory?(lib)
require 'merb-core'
require 'merb-core/test'
require 'merb-core/test/helpers'

# The lib under test
require "merb_datamapper"

# Satisfies Autotest and anyone else not using the Rake tasks
require 'spec'


Merb.start(
  :environment   => 'test',
  :adapter       => 'runner',
  :session_store => 'datamapper',
  :merb_root     => File.dirname(__FILE__),
  :log_level     => :debug
)

Spec::Runner.configure do |config|
  config.include Merb::Test::RequestHelper
end

Merb::Router.prepare do
  default_routes
end

class Application < Merb::Controller
end


require 'datamapper_id_map_controller'
require 'datamapper_session_controller'
require 'datamapper_model'

DataMapper.setup(:default, 'sqlite3::memory:')
DataObjects::Sqlite3.logger = Merb.logger
DataMapper.auto_migrate!
Post.create(:title => 'foo')
