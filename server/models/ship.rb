class Ship < Dry::Struct
  transform_keys(&:to_sym)

  attribute :id, Types::Integer
  attribute :fleet, Types::String

  SPANISH = 3
  TOTAL = 9

  ALL = [
    new(id: 0, fleet: Fleet::SPANIARDS),
    new(id: 1, fleet: Fleet::SPANIARDS),
    new(id: 2, fleet: Fleet::SPANIARDS),

    new(id: 3, fleet: Fleet::PIRATES),
    new(id: 4, fleet: Fleet::PIRATES),
    new(id: 5, fleet: Fleet::PIRATES),
    new(id: 6, fleet: Fleet::PIRATES),
    new(id: 7, fleet: Fleet::PIRATES),
    new(id: 8, fleet: Fleet::PIRATES)
  ]

  def self.find_active(turn_no)
    ALL[turn_no % ALL.size]
  end
end
