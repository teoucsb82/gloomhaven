
RSpec.describe Gloomhaven::CARDS do
  subject(:cards) { Gloomhaven::CARDS }

  it { expect(cards).not_to be nil }
  it { expect(cards).to be_a(Array) }
  it { expect(cards.length).to be > 0 }

  it 'does not have duplicate cards' do
    card_names = cards.map { |card| card['name'] }
    expect(card_names.uniq).to eq(card_names)
  end
end
