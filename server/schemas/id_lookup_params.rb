require 'dry/schema'

class IdLookupParams < Dry::Schema::Params
  define do
    required(:id).filled(:string)
  end
end

SchemaValidator.register :id_lookup, IdLookupParams.new
