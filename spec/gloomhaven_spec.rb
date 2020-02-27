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
    it { expect(characters.keys).to include('beast_tyrant') }
    it { expect(characters.keys).to include('berserker') }
    it { expect(characters.keys).to include('brute') }
    it { expect(characters.keys).to include('cragheart') }
    it { expect(characters.keys).to include('doomstalker') }
    it { expect(characters.keys).to include('elementalist') }
    it { expect(characters.keys).to include('mindthief') }
    it { expect(characters.keys).to include('nightshroud') }
    it { expect(characters.keys).to include('plagueherald') }
    it { expect(characters.keys).to include('quartermaster') }
    it { expect(characters.keys).to include('sawbones') }
    it { expect(characters.keys).to include('scoundrel') }
    it { expect(characters.keys).to include('soothsinger') }
    it { expect(characters.keys).to include('spellweaver') }
    it { expect(characters.keys).to include('summoner') }
    it { expect(characters.keys).to include('sunkeeper') }
    it { expect(characters.keys).to include('tinkerer') }
  end

  describe '::PERKS' do
    subject(:perks) { Gloomhaven::PERKS }
    it { expect(perks).not_to be nil }
    it { expect(perks).to be_a(Hash) }
    it { expect(perks.length).to be > 0 }
  end
end
