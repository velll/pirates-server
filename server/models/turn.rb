class Turn < Dry::Struct
  transform_keys(&:to_sym)

  attribute :game_id, Types::String
  attribute :no, Types::Coercible::String
  attribute :fleet, Types::String
  attribute :ship_id, Types::Coercible::Integer
  attribute :created_at, Types::Params::DateTime
  attribute :finished, Types::Params::Bool
  attribute :actions, Types::String.optional

  def self.for(game_id, turn_no)
    ship = Ship.find_active(turn_no)

    new(no: turn_no,
        game_id: game_id,
        fleet: ship.fleet,
        ship_id: ship.id,
        created_at: DateTime.now,
        finished: false,
        actions: nil)
  end

  def finalize(actions)
    dup.tap do |turn|
      turn.attributes[:finished] = true
      turn.attributes[:actions] = actions
    end
  end
end