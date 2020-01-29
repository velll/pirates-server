class Turn < Dry::Struct
  transform_keys(&:to_sym)

  attribute :game_id, Types::String
  attribute :no, Types::Coercible::Integer
  attribute :fleet, Types::String
  attribute :ship_id, Types::Coercible::Integer
  attribute :wind_bearing, Types::Coercible::String
  attribute :wind_force, Types::Coercible::Integer
  attribute :created_at, Types::Params::DateTime
  attribute :finished, Types::Params::Bool
  attribute :actions, Types::String

  def self.for(game_id, turn_no)
    ship = Ship.find_active(turn_no)
    wind = Wind.generate

    new(no: turn_no,
        game_id: game_id,
        fleet: ship.fleet,
        ship_id: ship.id,
        wind_bearing: wind.bearing,
        wind_force: wind.force,
        created_at: DateTime.now,
        finished: false,
        actions: '[]')
  end

  def finalize(actions)
    dup.tap do |turn|
      turn.attributes[:finished] = true
      turn.attributes[:actions] = actions
    end
  end
end
