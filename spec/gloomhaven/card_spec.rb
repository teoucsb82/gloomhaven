
RSpec.describe Gloomhaven::Card do

  subject(:card) { Gloomhaven::Card.new(name) }

  context 'when name is not a string' do
    let(:name) { nil }
    it { expect { card }.to raise_error(ArgumentError, 'Name must be a string')}
  end

  context 'when name is a string' do
    context 'when card name is valid' do
      let(:name) { 'Attack +0' }

      it { expect(card).to be_a(Gloomhaven::Card) }
      it { expect(card.name).to eq(name) }
      it { expect(card.attack).to eq(0) }
    end

    context 'when card is a crit' do
      context 'when card is an actual crit' do
        let(:name) { '2x' }
        it { expect(card.crit).to eq(true) }
        it { expect(card.bless?).to eq(false) }
        it { expect(card.shuffle).to eq(true) }
      end

      context 'when card is a blessing crit' do
        let(:name) { 'Bless' }
        it { expect(card.crit).to eq(true) }
        it { expect(card.bless?).to eq(true) }
        it { expect(card.shuffle).to eq(false) }
      end
    end

    context 'when card is a miss' do
      context 'when card is an actual miss' do
        let(:name) { 'Null' }
        it { expect(card.miss).to eq(true) }
        it { expect(card.curse?).to eq(false) }
        it { expect(card.shuffle).to eq(true) }
      end

      context 'when card is a blessing miss' do
        let(:name) { 'Curse' }
        it { expect(card.miss).to eq(true) }
        it { expect(card.curse?).to eq(true) }
        it { expect(card.shuffle).to eq(false) }
      end
    end

    context 'when card is not a crit or miss' do
      let(:name) { 'Attack +0' }
      it { expect(card.crit).to eq(false) }
      it { expect(card.miss).to eq(false) }
    end

    context 'when card is rolling' do
      let(:name) { 'Rolling Fire' }
      it { expect(card.rolling?).to eq(true) }
    end

    context 'when card name does not exist in the cards.yml' do
      let(:name) { 'Attack +100' }
      it { expect { card }.to raise_error(Gloomhaven::CardNotFoundError) }
    end
  end
end
