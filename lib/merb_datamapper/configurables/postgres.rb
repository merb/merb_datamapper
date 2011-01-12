module Merb
  module Orms
    module DataMapper
      module Configurable
        
        class Postgres < Base
          
          def to_uri
            "postgres://#{credentials}#{@config[:host] || "localhost"}#{":" + (@config[:port].to_s || "3306")}/#{@config[:database]}"
          end
        end
      end
    end
  end
end