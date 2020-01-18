class TurnRepo < Repo
  class << self
    def find(game_id, turn_no)
      record = connection.hgetall key(game_id, turn_no)
      raise Repo::NotFoundError if record.empty?

      Turn.new record
    end

    def create(turn)
      connection.incr "game:#{turn.game_id}:last"
      save(turn)
    end

    def save(turn)
      connection.hmset key(turn.game_id, turn.no), *turn.attributes.flatten

      turn
    end

    private

    def key(game_id, turn_no)
      "game:#{game_id}:#{turn_no}"
    end
  end
end
