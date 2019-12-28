require 'dry-struct'

module Types
  include Dry.Types()
end

Dir.glob('./server/{models}/*.rb').sort.each { |file| require file }
