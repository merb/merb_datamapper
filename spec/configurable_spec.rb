require 'spec_helper'
require 'merb_datamapper/configurables/base'
require 'merb_datamapper/configurables/mysql'
require 'merb_datamapper/configurables/sqlite3'

describe Merb::Orms::DataMapper::Configurable::Sqlite3 do
  
  before :all do
    @config = Merb::Orms::DataMapper::Configurable::Sqlite3.new :adapter => "sqlite3", :database => "sample.db"
  end
  
  it "should instantiate correctly and get a config hash" do
    @config.config.class.should == Hash
    @config.config[:adapter].should == "sqlite3"
  end
  
  it "should provide a correct db url" do
    @config.to_uri.should == "sqlite://#{Dir.getwd}/sample.db"
  end
  
end

describe Merb::Orms::DataMapper::Configurable::Mysql do
  
  before :all do
    @config = Merb::Orms::DataMapper::Configurable::Mysql.new :adapter => "mysql",
                                                              :database => "sample",
                                                              :host => "localhost",
                                                              :username => "root",
                                                              :password => "password"
  end
  
  it "should instantiate correctly and get a config hash" do
    @config.config.class.should == Hash
    @config.config[:adapter].should == "mysql"
  end
  
  it "should provide a correct db url" do
    @config.to_uri.should == "mysql://root:password@localhost:3306/sample"
  end
  
end