RSpec.describe Gloomhaven::PERKS do
  subject(:perks) { Gloomhaven::PERKS }

  it { expect(perks).not_to be nil }
  it { expect(perks).to be_a(Hash) }
  it { expect(perks.length).to be > 0 }

  it 'does not have duplicate perks' do
    expect(perks.keys.uniq).to eq(perks.keys)
  end
end
