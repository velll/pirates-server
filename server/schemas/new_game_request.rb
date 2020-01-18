require 'dry/schema'

class NewGameRequest < Dry::Schema::JSON
  define do
    required(:fleet).filled(:string)
  end
end

SchemaValidator.register :new_game, NewGameRequest.new
