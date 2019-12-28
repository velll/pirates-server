class Game < Dry::Struct
  transform_keys(&:to_sym)

  attribute :id, Types::String
  attribute :host_fleet, Types::String
  attribute :guest_fleet, Types::String
  attribute :created_at, Types::Params::DateTime
  attribute :golden_ship, Types::Coercible::Integer

  SPANISH_SHIPS = 3

  def self.for(fleet, golden_ship)
    id = SecureRandom.uuid
    new(id: id,
        host_fleet: fleet,
        guest_fleet: Fleet.enemy_of(fleet),
        golden_ship: golden_ship,
        created_at: DateTime.now)
  end

  def close; end
end
