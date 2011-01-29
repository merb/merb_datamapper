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
          
          def credentials
            return "" unless @config[:username]
            "#{@config[:username]}#{":" + @config[:password] || ""}@"
          end
          
          def to_uri
            #port defaults to 3306 as that is the mysql default iirc
            "#{self.class.to_s.split('::').last.downcase}://#{credentials}#{@config[:host] || "localhost"}#{":" + (@config[:port] || 3306).to_s}/#{@config[:database]}"
          end
          
        end
        
      end
    end
  end
end