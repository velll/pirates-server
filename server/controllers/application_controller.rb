class ApplicationController < Sinatra::Base
  ##########
  # Lobby
  ##########

  # List all open games
  get '/games' do
    json GameRepo.open_games.map(&:attributes)
  end

  # Create new game
  post '/games' do
    payload = JSON.parse request.body.read

    fleet = payload['fleet']

    unless Fleet.known? fleet
      raise ArgumentError, 'Unsupported fleet'
    end

    game = GameRepo.create Game.for(fleet, Ship.random_spanish.id)

    model_to_json game
  end

  # Add a new player to game (join)
  post '/game/:game/player' do
    game = GameRepo.find_open(params[:game])

    raise Error, 'No such game' if game.nil?

    # TODO: Save new player id to game when I start
    # identifying players

    game.close
    GameRepo.close game.id

    model_to_json game
  end

  ############
  # GamePlay
  ###########

  # Get details about a given game
  get '/game/:id' do
    model_to_json GameRepo.find(params[:id])
  end

  # Get details about a given turn
  get '/game/:id/turn/:turn_no' do
    game_id, turn_no = params[:id], params[:turn_no].to_i

    begin
      turn = TurnRepo.find(game_id, turn_no)
    rescue Repo::NotFoundError
      logger.info("Turn ##{turn_no} not found for game #{game_id}")
    end

    model_to_json turn || TurnRepo.create(Turn.for(game_id, turn_no))
  end

  private

  def model_to_json(model)
    json model.attributes
  end
end
