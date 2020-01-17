RSpec.describe Ship do
  it 'can find active ship' do
    expect(Ship.find_active(5).id).to eq 5
    expect(Ship.find_active(15).id).to eq 6
  end
end
