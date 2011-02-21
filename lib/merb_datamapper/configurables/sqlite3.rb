module Merb
  module Orms
    module DataMapper
      module Configurable
        class Sqlite3 < Base
          
          def to_uri
            "sqlite://#{@config[:path] || Dir.getwd}/#{@config[:database]}"
            uri = Addressable::URI.new :scheme => "sqlite",
                                       :path => [@config[:path] || Dir.getwd, @config[:database]].join("/")
            uri.to_s
          end
        end
      end
    end
  end
end