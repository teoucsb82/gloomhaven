RSpec.describe Gloomhaven do
  it 'has a version number' do
    expect(Gloomhaven::VERSION).not_to be nil
  end

  describe '.version' do
    it { expect(Gloomhaven.version).to eq Gloomhaven::VERSION }
  end

  describe '::CARDS' do
    subject(:cards) { Gloomhaven::CARDS }
    it { expect(cards).not_to be nil }
    it { expect(cards).to be_a(Array) }
    it { expect(cards.length).to be > 0 }
  end

  describe '::CHARACTERS' do
    subject(:characters) { Gloomhaven::CHARACTERS }
    it { expect(characters).not_to be nil }
    it { expect(characters).to be_a(Hash) }
    it { expect(characters.length).to eq(17) }

    it 'maps all character classes' do
      expect(characters.keys).to include('brute')
      expect(characters.keys).to include('cragheart')
      expect(characters.keys).to include('mindthief')
      expect(characters.keys).to include('tinkerer')
      expect(characters.keys).to include('scoundrel')
      expect(characters.keys).to include('spellweaver')
      expect(characters.keys).to include('sunkeeper')
    end
  end

  describe '::PERKS' do
    subject(:perks) { Gloomhaven::PERKS }
    it { expect(perks).not_to be nil }
    it { expect(perks).to be_a(Hash) }
    it { expect(perks.length).to be > 0 }
  end
end
