RSpec.describe Gloomhaven::Character do
  subject(:character) { Gloomhaven::Character.new(character_class) }
  let(:character_class) { 'Brute' }

  it { expect { character }.to_not raise_error }

  context 'when character_class is not a string' do
    let(:character_class) { nil }
    it { expect { character }.to raise_error(ArgumentError, 'Character class must be a String') }
  end

  context 'when character_class is not supported' do
    let(:character_class) { 'Paladin' }
    it { expect { character }.to raise_error(TypeError, "Invalid klass: #{character_class} is not supported. Must be one of the following: #{Gloomhaven::CHARACTER_NAMES}") }
  end

  describe '#hand_size' do
    subject(:hand_size) { character.hand_size }
    it { expect(hand_size).to be_a(Integer) }
  end

  describe '#health_scale' do
    subject(:health_scale) { character.health_scale }
    
    it { expect(health_scale).to be_a(String) }

    it 'returns Low, Medium, or High' do
      expect(Gloomhaven::Character.new('Brute').health_scale).to eq('High')
      expect(Gloomhaven::Character.new('Scoundrel').health_scale).to eq('Medium')
      expect(Gloomhaven::Character.new('Spellweaver').health_scale).to eq('Low')
    end
  end

  describe '#hex_color' do
    subject(:hex_color) { character.hex_color }
    it { expect(hex_color).to be_a(String) }
    it { expect(hex_color.length).to eq(6) }
  end

  describe '#name' do
    subject(:name) { character.name }
    
    it { expect(name).to be_a(String) }

    it 'returns the titleized case of the name' do
      expect(Gloomhaven::Character.new('BEAST TYRANT').name).to eq('Beast Tyrant')
      expect(Gloomhaven::Character.new('BeAsT tYrAnT').name).to eq('Beast Tyrant')
      expect(Gloomhaven::Character.new('beast tyrant').name).to eq('Beast Tyrant')
    end
  end

  describe '#perks' do
    subject(:perks) { character.perks }

    it { expect(perks).to be_a(Hash) }
    it { expect(perks).not_to be_empty }
  end

  describe '#spoiler_name' do
    subject(:spoiler_name) { character.spoiler_name }
    
    context 'when class is a starter class' do
      let(:character_class) { 'Scoundrel' }
      it { expect(spoiler_name).not_to be_nil }
      it { expect(spoiler_name).to eq(character_class) }
    end

    context 'when class has a spoiler name' do
      let(:character_class) { 'Plagueherald' }
      it { expect(spoiler_name).not_to be_nil }
      it { expect(spoiler_name).not_to eq(character_class) }
      it { expect(spoiler_name).to eq('Cthulu') }
    end
  end
end