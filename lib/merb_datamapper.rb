require "rubygems"
require "merb-core"

require "dm-core"
require "merb_datamapper/connection"

require 'merb_datamapper/configurables/base'
require 'merb_datamapper/configurables/mysql'
require 'merb_datamapper/configurables/sqlite3'

Merb::Plugins.add_rakefiles "merb_datamapper" / "merbtasks"

# conditionally assign things, so as not to override previously set options.
# This is most relevent for :use_repository_block, which is used later in this file.
unless Merb::Plugins.config[:merb_datamapper].has_key?(:use_repository_block)
  Merb::Plugins.config[:merb_datamapper][:use_repository_block] = true
end

unless Merb::Plugins.config[:merb_datamapper].has_key?(:session_storage_name)
  Merb::Plugins.config[:merb_datamapper][:session_storage_name] = 'sessions'
end

unless Merb::Plugins.config[:merb_datamapper].has_key?(:session_repository_name)
  Merb::Plugins.config[:merb_datamapper][:session_repository_name] = :default
end

module DataMapper
  module Resource

    # actionorm compliance
    alias new_record? new?

  end
end

# Sets DataMapper as ORM
Merb.orm = :datamapper

class Merb::Orms::DataMapper::Connect < Merb::BootLoader
  after BeforeAppLoads

  def self.run
    Merb.logger.verbose! "Merb::Orms::DataMapper::Connect block."

    # check for the presence of database.yml
    if File.file?(Merb.dir_for(:config) / "database.yml")
      # if we have it, connect
      Merb::Orms::DataMapper.connect
    else
      # assume we'll be told at some point
      Merb.logger.info "No database.yml file found in #{Merb.dir_for(:config)}, assuming database connection(s) established in the environment file in #{Merb.dir_for(:config)}/environments"
    end

    # if we use a datamapper session store, require it.
    Merb.logger.verbose! "Checking if we need to use DataMapper sessions"
    if Merb::Config.session_store == 'datamapper'
      Merb.logger.verbose! "Using DataMapper sessions"
      require "merb_datamapper/data_mapper_session"
    end

    # take advantage of the fact #id returns the key of the model, unless #id is a property
    Merb::Router.root_behavior = Merb::Router.root_behavior.identify(DataMapper::Resource => :id)

    Merb.logger.verbose! "Merb::Orms::DataMapper::Connect complete"
  end
end

class Merb::Orms::DataMapper::Finalize < Merb::BootLoader
  after LoadClasses

  def self.run
    if DataMapper.respond_to?(:finalize)
      DataMapper.finalize
    else
      DataMapper::Model.descendants.each do |model|
        model.relationships.each_value { |r| r.child_key }
      end
    end
  end
end



class Merb::Orms::DataMapper::IdentityMapSupport < Merb::BootLoader

  after RackUpApplication

  def self.run

    if Merb::Plugins.config[:merb_datamapper][:use_repository_block]
      app = Merb::Config[:app]
      def app.call(env)
        DataMapper.repository do |r|
          Merb.logger.debug "In repository block #{r.name}"
          super
        end
      end
    end

  end
end


generators = File.join(File.dirname(__FILE__), 'generators')
Merb.add_generators generators / 'data_mapper_model'
Merb.add_generators generators / 'data_mapper_resource_controller'
Merb.add_generators generators / 'data_mapper_migration'
