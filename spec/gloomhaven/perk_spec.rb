RSpec.describe Gloomhaven::Perk do
  subject(:perk) { Gloomhaven::Perk.new(key) }
  let(:key) { 'remove_two_minus_one_cards' }

  context 'when key is supported by perks.yml' do
    it { expect { perk }.not_to raise_error }
    it { expect(perk).to be_a(Gloomhaven::Perk) }
  end

  context 'when key is not supported by perks.yml' do
    let(:key) { nil }
    it { expect { perk }.to raise_error(TypeError, "Perk #{key} is not supported") }
  end

  context 'character specific perks' do
    Gloomhaven::CHARACTERS.each do |character_class, data|
      next if data['perks'].nil?
      data['perks'].each do |perk, count|
        it "#{character_class.capitalize}: Perk #{perk} exists" do
          expect { Gloomhaven::Perk.new(perk) }.not_to raise_error
        end
      end
    end
  end

  describe '#cards' do
    subject(:cards) { perk.cards }

    it { expect(cards).to be_a(Hash) }
    it { expect(cards.keys).to eq(['add', 'remove']) }
    it { expect(cards['add']).to be_a(Array) }
    it { expect(cards['remove']).to be_a(Array) }

    describe 'all perks are valid for cards' do
      Gloomhaven::PERKS.keys.each do |perk_key|
        it "supports #{perk_key} card from the perks.yml" do
          expect { Gloomhaven::Perk.new(perk_key).cards }.not_to raise_error
        end
      end
    end
  end
end
