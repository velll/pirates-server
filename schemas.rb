require 'dry-schema'

class SchemaValidator
  extend Dry::Container::Mixin

  class SchemaError < StandardError; end
end

module Schemable
  def validate_with(schema, hash)
    result = SchemaValidator.resolve(schema).call(hash)

    unless result.errors.empty?
      raise SchemaValidator::SchemaError, result.errors(full: true).first.text
    end

    result
  end
end

Dir.glob('./server/{schemas}/*.rb').sort.each { |file| require file }
