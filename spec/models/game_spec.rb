RSpec.describe Game do
  it 'validates its structure' do
    game = Game.new(id: '123abc', fleet: 'pirates', created_at: DateTime.now)

    expect(game.id).to eq '123abc'
    expect(game.fleet).to eq 'pirates'
  end

  it 'does not allow wrong structure' do
    expect { Game.new(something: 'completely different') }
      .to raise_error Dry::Struct::Error
  end
end
