require 'redis'

class Repo
  class << self
    class NotFoundError < StandardError; end

    # rubocop:disable Style/ClassVars
    def connect(conn)
      @@connection = conn
    end

    def connection
      @@connection
    end
    # rubocop:enable Style/ClassVars
  end
end
