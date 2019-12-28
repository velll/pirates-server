class GameRepo < Repo
  class << self
    def find(id)
      Game.new connection.hgetall("game:#{id}")
    end

    def create(game)
      connection.sadd 'open_games', game.id
      connection.hmset "game:#{game.id}", *game.attributes.flatten

      game
    end

    def open_games
      ids = connection.smembers('open_games')

      ids.map do |id|
        find(id)
      end
    end

    def find_open(id)
      raise NotFoundError unless connection.sismember('open_games', id)

      find(id)
    end

    def close(id)
      connection.srem 'open_games', id
    end
  end
end
