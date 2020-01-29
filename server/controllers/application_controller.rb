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
    with_rewind { |body| logger.debug body }

    payload = validate_with :new_game, JSON.parse(request.body.read)

    unless Fleet.known? payload[:fleet]
      raise ArgumentError, 'Unsupported fleet'
    end

    game = GameRepo.create Game.for(payload[:fleet], Ship.random_spanish.id)

    model_to_json game
  end

  # Add a new player to game (join)
  post '/game/:id/player' do
    pars = validate_with :id_lookup, params
    game = GameRepo.find_open(pars[:id])

    raise Error, 'No such game' if game.nil?

    # TODO: Save new player id to game when I start
    # identifying players

    game.close
    GameRepo.close game.id

    model_to_json game
  end

  ###########
  # GamePlay
  ###########

  # Get details about a given game
  get '/game/:id' do
    pars = validate_with :id_lookup, params

    model_to_json GameRepo.find(pars[:id])
  end

  # Get details about a given turn
  get '/game/:game_id/turn/:turn_no' do
    pars = validate_with :turn_lookup, params

    begin
      turn = TurnRepo.find(pars[:game_id], pars[:turn_no])
    rescue Repo::NotFoundError
      logger.info("Turn ##{pars[:turn_no]} not found for #{pars[:game_id]}")
    end

    model_to_json turn || TurnRepo.create(Turn.for(pars[:game_id],
                                                   pars[:turn_no]))
  end

  # save actions

  post '/game/:game_id/turns/:turn_no/actions' do
    with_rewind { |body| logger.info body }
    pars = validate_with :turn_lookup, params

    stored_turn = TurnRepo.find(pars[:game_id], pars[:turn_no])

    payload = request.body.read
    turn = stored_turn.finalize(payload)

    model_to_json TurnRepo.save(turn)
  end

  private

  def model_to_json(model)
    json model.attributes
  end
end
