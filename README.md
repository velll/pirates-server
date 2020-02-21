# Pirates-server

A backend json API for pirates game.

- `GET /games` lists currently open games
- `POST /games` creates a new game
- `POST '/game/:id/player'` adds a player to the game (join game)
- `GET '/game/:id'` to fetch info about a game
- `GET '/game/:game_id/turn/:turn_no'` to fetch details about a turn
- `POST '/game/:game_id/turns/:turn_no/actions'` to save actions done during a turn
