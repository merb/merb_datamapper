module Merb
  module Orms
    module DataMapper
      module Configurable
        
        class Postgres < Base
          
          def to_uri
            credentials = @config[:username] ? "#{@config[:username]}#{":" + @config[:password] || ""}@" : ""
            "postgres://#{credentials}#{@config[:host] || "localhost"}#{":" + (@config[:port] || "3306")}/#{@config[:database]}"
          end
          
        end
        
      end
    end
  end
end