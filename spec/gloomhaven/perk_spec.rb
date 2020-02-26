RSpec.describe Gloomhaven::Perk do
  subject(:perk) { Gloomhaven::Perk.new(key) }
  let(:key) { nil }

  context 'when key is not supported by perks.yml' do
    let(:key) { 'perk does not exist' }
    it { expect { perk }.to raise_error(TypeError, "Perk #{key} is not supported") }
  end

  context 'when key is supported by perks.yml' do
    let(:key) { 'remove_two_minus_one_cards' }

    it { expect { perk }.not_to raise_error }
    it { expect(perk).to be_a(Gloomhaven::Perk) }
  end
end
