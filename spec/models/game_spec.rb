RSpec.describe Game do
  it 'validates its structure' do
    game = Game.new(id: '123abc',
                    host_fleet: 'pirates',
                    guest_fleet: 'spaniards',
                    golden_ship: 0,
                    created_at: DateTime.now)

    expect(game.id).to eq '123abc'
    expect(game.host_fleet).to eq 'pirates'
  end

  it 'does not allow wrong structure' do
    expect { Game.new(something: 'completely different') }
      .to raise_error Dry::Struct::Error
  end
end
