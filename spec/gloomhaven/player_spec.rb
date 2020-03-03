RSpec.describe Gloomhaven::Player do
  subject(:player) { Gloomhaven::Player.new(options) }
  let(:options) { { character_class: character_class, name: name } }
  let(:character_class) { 'brute' }
  let(:name) { 'Brute Player' }

  it { expect(player).to be_a(Gloomhaven::Player) }

  context 'when character class is missing' do
    let(:character_class) { nil }
    it { expect { player }.to raise_error(ArgumentError, 'options[:character_class] cannot be blank') }
  end

  context 'when character class is present' do
    context 'when character class is not supported' do
      let(:character_class) { 'some fake class' }
      it { expect { player }.to raise_error(TypeError, "Invalid character_class: #{character_class} is not supported. Must be one of the following: #{Gloomhaven::CHARACTERS.keys}") }
    end

    context 'when character class is supported' do
      let(:character_class) { 'brute' }
      it { expect { player }.not_to raise_error }
    end
  end

  context 'when name is missing' do
    let(:name) { nil }
    it { expect { player }.to raise_error(ArgumentError, 'options[:name] cannot be blank') }
  end

  context 'when name is present' do
    context 'when name is not a String' do
      let(:name) { 123 }
      it { expect { player }.to raise_error(ArgumentError, 'options[:name] must be a String') }
    end
  end

  describe '#add_perk!' do
    subject(:add_perk!) { player.add_perk!(perk) }

    context 'when card is a valid Gloomhaven::Perk object' do
      context 'when the character class supports the perk' do
        let(:character_class) { 'brute' }
        let(:perk) { Gloomhaven::Perk.new('remove_two_minus_one_cards') }

        context 'when the character has remaining slots available for the perk' do
          it 'adds the perk to the player' do
            add_perk!
            expect(player.perks).to include(perk)
          end

          it 'updates the attack modifier deck accordingly' do
            expect(player.deck.cards.size).to eq(20)
            add_perk!
            expect(player.deck.cards.size).to eq(18)
          end
        end

        context 'when the character has already selected the perk the maximum number of times' do
          it 'raises an error' do
            # in this context, the brute is going to attempt to add the same perk twice, but is only allowed to add it a single time.
            # first time we raise no error, second time it raises an error
            expect(player.perks.count).to eq(0)
            expect { player.add_perk!(perk) }.not_to raise_error
            expect(player.perks.count).to eq(1)
            expect { player.add_perk!(perk) }.to raise_error(ArgumentError, "#{character_class} has the maximum number of #{perk.description} perks")
            expect(player.perks.count).to eq(1)
          end
        end
      end

      context 'when the character class does not support the perk' do
        let(:character_class) { 'brute' }
        let(:perk) { Gloomhaven::Perk.new('remove_four_plus_zero_cards') }

        it 'raises an error and does not update the attack modifier deck' do
          expect(player).not_to receive(:update_attack_modifier_deck_from!).with(perk)
          expect { add_perk! }.to raise_error(ArgumentError, "#{character_class} cannot select #{perk.description}")
        end
      end
    end

    context 'when card is not a valid Gloomhaven::Perk object' do
      let(:perk) { nil }

      it 'raises an error and does not update the attack modifier deck' do
        expect(player).not_to receive(:update_attack_modifier_deck_from!)
        expect { add_perk! }.to raise_error(TypeError, 'Perk must be a Gloomhaven::Perk')
      end
    end
  end
end