require 'redis'
require 'dry/container'

class Repo
  extend Dry::Container::Mixin

  class NotFoundError < StandardError; end

  class << self
    def connect(conn)
      register :connection, conn
    end

    def connection
      Repo.resolve :connection
    end
  end
end
