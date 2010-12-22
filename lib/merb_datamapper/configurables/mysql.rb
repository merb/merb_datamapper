module Merb
  module Orms
    module DataMapper
      module Configurable
        
        class Mysql < Base
        
          def to_uri
            "mysql://#{@config[:username]}#{":" + @config[:password] || ""}@#{@config[:host]}#{":" + (@config[:port] || "3306")}/#{@config[:database]}"
          end
          
        end
        
      end
    end
  end
end