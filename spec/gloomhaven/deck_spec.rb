RSpec.describe Gloomhaven::Deck do

  subject(:deck) { Gloomhaven::Deck.new }

  context 'when deck has not been modified' do
    describe '#size' do
      subject(:size) { deck.size }
      it { expect(size).to eq(20) }
    end

    describe '#average_attack' do
      subject(:average_attack) { deck.average_attack }
      it { expect(average_attack).to eq(0) }
    end

    describe '#cards' do
      subject(:cards) { deck.cards }

      it 'returns the default starting set of 20 modifier cards' do
        expect(cards.select { |card| card.name == 'Attack +0' }.count).to eq(6)
        expect(cards.select { |card| card.name == 'Attack +1' }.count).to eq(5)
        expect(cards.select { |card| card.name == 'Attack +2' }.count).to eq(1)
        expect(cards.select { |card| card.name == 'Attack -1' }.count).to eq(5)
        expect(cards.select { |card| card.name == 'Attack -2' }.count).to eq(1)
        expect(cards.select { |card| card.name == 'Attack -2' }.count).to eq(1)
        expect(cards.select { |card| card.name == 'Null' }.count).to eq(1)
        expect(cards.select { |card| card.name == '2x' }.count).to eq(1)
      end

      it 'does not include any blessings or curses' do
        expect(cards.select { |card| card.name == 'Bless' }.count).to eq(0)
        expect(cards.select { |card| card.name == 'Curse' }.count).to eq(0)
      end
    end
  end

  describe '#add!' do
    subject(:add!) { deck.add!(card) }
    let(:card) { Gloomhaven::Card.find('Attack +1') }

    context 'when card is a valid Gloomhaven::Card object' do
      it { expect { add! }.not_to raise_error }

      it 'adds the card to the deck' do
        expect(deck.size).to eq(20)
        add!
        expect(deck.size).to eq(21)
      end

      it 'returns the modified array of cards' do
        expect(add!).to eq(deck.cards)
      end
    end

    context 'when card is not a Gloomhaven::Card object' do
      let(:card) { 'I AM A CARD' }
      it { expect { add! }.to raise_error(TypeError, 'Card must be a Gloomhaven::Card' ) }
    end
  end

  describe '#bless!' do
    subject(:bless) { deck.bless! }

    it 'adds 1 bless card to the deck' do
      expect(deck.cards.select { |card| card.name == 'Bless' }.count).to eq(0)
      bless
      expect(deck.cards.select { |card| card.name == 'Bless' }.count).to eq(1)
    end

    it 'increases the deck size by one' do
      original_size = deck.size
      bless
      expect(deck.size).to eq(original_size + 1)
    end

    it 'soft shuffles the current deck' do
      expect(deck).not_to receive(:shuffle!).with(nil)
      expect(deck).not_to receive(:shuffle!).with(true)
      expect(deck).to receive(:shuffle!).with(false)
      bless
    end
  end

  describe '#curse!' do
    subject(:curse) { deck.curse! }

    it 'adds 1 curse card to the deck' do
      expect(deck.cards.select { |card| card.name == 'Curse' }.count).to eq(0)
      curse
      expect(deck.cards.select { |card| card.name == 'Curse' }.count).to eq(1)
    end

    it 'increases the deck size by one' do
      original_size = deck.size
      curse
      expect(deck.size).to eq(original_size + 1)
    end

    it 'soft shuffles the current deck' do
      expect(deck).not_to receive(:shuffle!).with(nil)
      expect(deck).not_to receive(:shuffle!).with(true)
      expect(deck).to receive(:shuffle!).with(false)
      curse
    end
  end

  describe '#draw' do
    subject(:draw) { deck.draw }

    it { expect(draw).to be_a(Gloomhaven::Card) }

    it 'returns the top card of the current deck' do
      deck.shuffle!
      first_card = deck.cards.first
      last_card = deck.cards.last
      card = draw
      expect(card).to eq(first_card)
      expect(card).not_to eq(last_card)
    end

    context 'when drawn card is not a blessing or curse' do
      it 'adds the drawn card to the drawn pile' do
        draw
        expect(deck.drawn_cards.size).to eq(1)
      end
    end

    context 'when drawn card is blessing' do
      let(:bless_card) { Gloomhaven::Card.find('Bless') }

      before do
        # put a "bless" card on top of the deck
        deck.cards.unshift(bless_card)
      end

      it 'adds the drawn card to the drawn_cards pile' do
        expect(draw).to eq(bless_card)
      end

      it 'immediately removes the bless card from the deck after drawing it' do
        draw
        expect(deck.drawn_cards.size).to eq(0)
      end
    end

    context 'when drawn card is curse' do
      let(:curse_card) { Gloomhaven::Card.find('Curse') }

      before do
        # put a "curse" card on top of the deck
        deck.cards.unshift(curse_card)
      end

      it 'adds the drawn card to the drawn_cards pile' do
        expect(draw).to eq(curse_card)
      end

      it 'immediately removes the curse card from the deck after drawing it' do
        draw
        expect(deck.drawn_cards.size).to eq(0)
      end
    end
  end

  describe '#remove!' do
    subject(:remove!) { deck.remove!(card) }

    context 'when card is a Gloomhaven::Card object' do
      context 'when the card to remove exists in the deck' do
        let(:card) { Gloomhaven::Card.find('Attack +0') } # default deck contains an attack +0 card

        it { expect { remove! }.not_to raise_error }

        it 'removes the card from the deck' do
          expect(deck.size).to eq(20)
          remove!
          expect(deck.size).to eq(19)
        end

        it 'returns the modified array of cards' do
          expect(remove!).to eq(deck.cards)
        end
      end

      context 'when the card to remove does not exist in the deck' do
        let(:bless_card) { Gloomhaven::Card.find('Bless') } # default deck does not contain bless
        let(:curse_card) { Gloomhaven::Card.find('Curse') } # default deck does not contain curse

        it { expect { deck.remove!(bless_card) }.to raise_error(ArgumentError, "Card: 'Bless' not found in deck") }
        it { expect { deck.remove!(curse_card) }.to raise_error(ArgumentError, "Card: 'Curse' not found in deck") }
      end
    end

    context 'when card is not a Gloomhaven::Card object' do
      let(:card) { 'I AM A CARD' }
      it { expect { remove! }.to raise_error(TypeError, 'Card must be a Gloomhaven::Card' ) }
    end
  end

  describe '#shuffle!' do
    subject(:shuffle) { deck.shuffle!(full_shuffle) }

    context 'when full_shuffle is true' do
      let(:full_shuffle) { true }

      # technically this has a 1:2432902008176640000 chance of that false negativing if the 20 cards are ever shuffled back into the default order.
      # willing to take that chance in this spec...
      it 'randomizes the order of cards' do
        original_cards = deck.cards
        shuffle
        expect(original_cards).to_not eq(deck.cards)
      end

      it 'shuffles the entire deck together' do
        expect(deck.cards.size).to eq(20)
        deck.draw
        expect(deck.cards.size).to eq(19)
        shuffle
        expect(deck.cards.size).to eq(20)
      end
    end

    context 'when full_shuffle is false' do
      let(:full_shuffle) { false }

      it 'only shuffles the remaining cards' do
        expect(deck.cards.size).to eq(20)
        deck.draw
        expect(deck.cards.size).to eq(19)
        shuffle
        expect(deck.cards.size).to eq(19)
      end
    end
  end
end
