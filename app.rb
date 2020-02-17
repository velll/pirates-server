$LOAD_PATH.unshift('server') unless $LOAD_PATH.include?('server')
$LOAD_PATH.unshift(__dir__) unless $LOAD_PATH.include?(__dir__)

require 'securerandom'
require 'redis'
require 'pry'

require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/config_file'

require 'repositories/repo'
require 'repositories/game_repo'
require 'repositories/turn_repo'

require 'lib/rewindable'

require 'models'
require 'schemas'

class ApplicationController < Sinatra::Base
  include Schemable
  include Rewindable

  configure do
    # TODO: Switch back on if the web interface ends up rendered
    # from here rather than being a static page
    set :protection, except: [:json_csrf]
    set :protection, origin_whitelist: ['localhost']
  end

  set :strict_paths, false
  set :show_exceptions, false
  set :logging, true

  register Sinatra::ConfigFile
  config_file 'config.yml'

  unless ENV['REDIS_HOST'] && ENV['REDIS_PORT']
    raise 'Set REDIS_HOST and REDIS_PORT'
  end

  Repo.connect Redis.new(host: ENV['REDIS_HOST'],
                         port: ENV['REDIS_PORT'])

  error do
    content_type :json
    status 400 # or whatever

    e = env['sinatra.error']
    { message: e.message }.to_json
  end
end

require 'controllers/application_controller'
