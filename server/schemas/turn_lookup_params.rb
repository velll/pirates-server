require 'dry/schema'

class TurnLookupParams < Dry::Schema::Params
  define do
    required(:game_id).filled(:string)
    required(:turn_no).filled(:integer)
  end
end

SchemaValidator.register :turn_lookup, TurnLookupParams.new
