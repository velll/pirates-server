class Game < Dry::Struct
  transform_keys(&:to_sym)

  attribute :id, Types::String
  attribute :host_fleet, Types::String
  attribute :guest_fleet, Types::String
  attribute :created_at, Types::Params::DateTime

  def self.for(fleet)
    id = SecureRandom.uuid
    new(id: id,
        host_fleet: fleet,
        guest_fleet: Fleet.enemy_of(fleet),
        created_at: DateTime.now)
  end

  def close; end
end
