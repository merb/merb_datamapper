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
          
        end
        
      end
    end
  end
end