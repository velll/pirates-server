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

    model_to_json game
  end

  get '/game/:id' do
    model_to_json GameRepo.find(params[:id])
  end

  post '/game/:game/player' do
    game = GameRepo.find_open(params[:game])

    raise Error, 'No such game' if game.nil?

    # TODO: Save new player id to game when I start
    # identifying players

    game.close
    GameRepo.close game.id

    model_to_json game
  end

  private

  def model_to_json(model)
    json model.attributes
  end
end