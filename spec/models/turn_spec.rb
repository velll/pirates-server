RSpec.describe Turn do
  it 'can be easily created' do
    game_id = '22e04a30-0003-4339-9f3e-92d5f888ada9'
    turn_no = 10

    turn = Turn.for(game_id, turn_no)

    expect(turn.game_id).to eq game_id
    expect(turn.no).to eq turn_no
  end
end
