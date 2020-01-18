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

require 'models'

class ApplicationController < Sinatra::Base
  set :strict_paths, false
  set :show_exceptions, false
  set :logging, true

  register Sinatra::ConfigFile
  config_file 'config.yml'

  Repo.connect Redis.new(host: settings.storage['host'],
                         port: settings.storage['port'])

  error do
    content_type :json
    status 400 # or whatever

    e = env['sinatra.error']
    { message: e.message }.to_json
  end
end

require 'controllers/application_controller'
