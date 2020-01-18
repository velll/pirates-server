require 'redis'

class Repo
  class NotFoundError < StandardError; end

  class << self
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
