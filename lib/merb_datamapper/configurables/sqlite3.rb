module Merb
  module Orms
    module DataMapper
      module Configurable
        class Sqlite3 < Base
          
          def to_uri
            "sqlite://#{@config[:path] || Dir.getwd}/#{@config[:database]}"
          end
        end
      end
    end
  end
end