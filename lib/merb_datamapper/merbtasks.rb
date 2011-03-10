require 'fileutils'
require 'merb_datamapper/connection'

namespace :db do
  
  task :merb_start do
    Merb.start_environment :adapter => 'runner',
    :environment => ENV['MERB_ENV'] || 'development'
  end
  
  desc "Create a sample database.yml file"
  task :database_yaml => :merb_env do
    sample_location = File.expand_path('../database.yml.sample', __FILE__)
    target_location = Merb.dir_for(:config)
    FileUtils.cp sample_location, target_location
  end
  desc "Perform automigration"
  task :automigrate => :merb_env do
    ::DataMapper.finalize if ::DataMapper.respond_to?(:finalize)
    ::DataMapper.auto_migrate!
  end
  desc "Perform non destructive automigration"
  task :autoupgrade => :merb_env do
    ::DataMapper.finalize if ::DataMapper.respond_to?(:finalize)
    ::DataMapper.auto_upgrade!
  end

  namespace :migrate do
    task :load => :merb_env do
      require 'dm-migrations/migration_runner'
      FileList["schema/migrations/*.rb"].each do |migration|
        load migration
      end
    end

    desc "Migrate up using migrations"
    task :up, :version, :needs => :load do |t, args|
      version = args[:version] || ENV['VERSION']
      migrate_up!(version)
    end
    desc "Migrate down using migrations"
    task :down, :version, :needs => :load do |t, args|
      version = args[:version] || ENV['VERSION']
      migrate_down!(version)
    end
  end

  desc "Migrate the database to the latest version"
  task :migrate => 'db:migrate:up'

  desc "Create the database"
  task :create do
    config = Merb::Orms::DataMapper.config
    puts "Creating database '%s'" % (config[:adapter] == 'sqlite3' ? config[:path] : config[:database])
    case config[:adapter]
    when 'postgres'
      system('createdb', "-U #{config[:username]}", config[:database].to_s)
    when 'mysql'
      user, password, database = config[:username], config[:password], config[:database]
      args = ["--user=#{user}"]
      args << "--password=#{password}" if password
      args << "-e create database #{database}"
      system('mysql', *args)
    when 'sqlite3'
      Rake::Task['rake:db:automigrate'].invoke
    else
      raise "Adapter #{config[:adapter]} not supported for creating databases yet."
    end
  end

  desc "Drop the database (postgres and mysql only)"
  task :drop do
    config = Merb::Orms::DataMapper.config
    puts "Dropping database '#{config[:database]}'"
    case config[:adapter]
    when 'postgres'
      system('dropdb', "-U #{config[:username]}", config[:database].to_s)
    when 'mysql'
      user, password, database = config[:username], config[:password], config[:database]
      args = ["--user=#{user}"]
      args << "--password=#{password}" if password
      args << "-e drop database #{database}"
      system('mysql', *args)
    else
      raise "Adapter #{config[:adapter]} not supported for dropping databases yet.\ntry db:automigrate"
    end
  end

  desc "Drop the database, and migrate from scratch"
  task :reset => [:drop, :create, :migrate]
end

namespace :sessions do
  desc "Perform automigration for sessions"
  task :create => :merb_env do
    Merb::DataMapperSessionStore.auto_migrate!
  end

  desc "Clears sessions"
  task :clear => :merb_env do
    Merb::DataMapperSessionStore.all.destroy!
  end
end

