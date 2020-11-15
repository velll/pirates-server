# Pirates-server

A backend json API for pirates game.

- `GET /games` lists currently open games
- `POST /games` creates a new game
- `POST '/games/:id/players'` adds a player to the game (join game)
- `GET '/games/:id'` to fetch info about a game
- `GET '/games/:game_id/turns/:turn_no'` to fetch details about a turn
- `POST '/games/:game_id/turns/:turn_no/actions'` to save actions done during a turn
