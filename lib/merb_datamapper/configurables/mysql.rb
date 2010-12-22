module Merb
  module Orms
    module DataMapper
      module Configurable
        
        class Mysql < Base
        
          def to_uri
            credentials = @config[:username] ? "#{@config[:username]}#{":" + @config[:password] || ""}@" : ""
            "mysql://#{credentials}#{@config[:host] || "localhost"}#{":" + (@config[:port] || "3306")}/#{@config[:database]}"
          end
          
        end
        
      end
    end
  end
end