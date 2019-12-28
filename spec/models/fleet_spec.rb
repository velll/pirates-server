RSpec.describe Fleet do
  it 'can find an enemy' do
    expect(Fleet.enemy_of('pirates')).to eq 'spaniards'
    expect(Fleet.enemy_of('spaniards')).to eq 'pirates'
  end

  it 'knows the options' do
    expect(Fleet.known?('pirates')). to be true
    expect(Fleet.known?('australians')). to be false
  end
end
