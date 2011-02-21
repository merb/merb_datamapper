module Merb
  module Orms
    module DataMapper
      
      module Configurable
        
        class Base
          
          attr_accessor :config
          
          def initialize config
            @config = config
          end
          
          def empty?
            @config.empty? 
          end
          
          def to_uri
            options = { :scheme => self.class.to_s.split('::').last.downcase,
                        :path => @config[:database],
                        :host => @config[:host] || "localhost",
                        :port => @config[:port] || 3306,
                        :user => @config[:username] || nil,
                        :password => @config[:password] || nil
            }
            Addressable::URI.new(options).to_s
          end
          
        end
        
      end
    end
  end
end