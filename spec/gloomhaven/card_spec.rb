RSpec.describe Gloomhaven::Card do
  subject(:card) { Gloomhaven::Card.new(number) }

  context 'when number is nil' do
    let(:number) { nil }
    it { expect { card.number }.to raise_error(ArgumentError, 'Number must be an integer')}
  end

  context 'when number is not an integer' do
    it { expect { Gloomhaven::Card.new(String.new) }.to raise_error(ArgumentError, 'Number must be an integer')}
    it { expect { Gloomhaven::Card.new(Array.new) }.to raise_error(ArgumentError, 'Number must be an integer')}
    it { expect { Gloomhaven::Card.new(3.333) }.to raise_error(ArgumentError, 'Number must be an integer')}
  end

  context 'when number is not found in the yaml' do
    it { expect { Gloomhaven::Card.new(-1) }.to raise_error(ArgumentError, 'Number is not supported')}
    it { expect { Gloomhaven::Card.new(999) }.to raise_error(ArgumentError, 'Number is not supported')}
  end

  context 'when number is numeric and within range' do
    let(:number) { 1 }

    describe 'default attributes' do
      it { expect { card }.not_to raise_error }
      it { expect(card.attack).to be_a(Integer) }
      it { expect(card.name).to be_a(String) }
      it { expect(card.shuffle).not_to be_nil }
    end

    context 'when card is a +0 attack' do
      let(:number) { 1 }
      it { expect(card.attack).to eq(0) }
      it { expect(card.shuffle).to eq(false) }
    end

    context 'when card is a +1 attack' do
      let(:number) { 2 }
      it { expect(card.attack).to eq(1) }
      it { expect(card.shuffle).to eq(false) }
    end

    context 'when card is a -1 attack' do
      let(:number) { 3 }
      it { expect(card.attack).to eq(-1) }
      it { expect(card.shuffle).to eq(false) }
    end

    context 'when card is a +2 attack' do
      let(:number) { 4 }
      it { expect(card.attack).to eq(2) }
      it { expect(card.shuffle).to eq(false) }
    end

    context 'when card is a -2 attack' do
      let(:number) { 5 }
      it { expect(card.attack).to eq(-2) }
      it { expect(card.shuffle).to eq(false) }
    end

    context 'when card is a miss' do
      let(:number) { 6 }
      it { expect(card.attack).to eq(0) }
      it { expect(card.miss).to eq(true) }
      it { expect(card.shuffle).to eq(true) }
    end

    context 'when card is a 2x' do
      let(:number) { 7 }
      it { expect(card.attack).to eq(0) }
      it { expect(card.crit).to eq(true) }
      it { expect(card.shuffle).to eq(true) }
    end
  end
end
