class ApplicationController < Sinatra::Base
  get '/games' do
    json GameRepo.open_games.map(&:attributes)
  end

  post '/games' do
    payload = JSON.parse request.body.read

    fleet = payload['fleet']

    unless Fleet.options.include? fleet
      raise ArgumentError, 'Unsupported fleet'
    end

    game = GameRepo.create Game.for(fleet)

    json game.attributes
  end

  post '/game/:game/player' do
    game = GameRepo.find_open(params[:game])

    raise Error, 'No such game' if game.nil?

    game.close
    GameRepo.close game.id

    json game.attributes
  end
end
