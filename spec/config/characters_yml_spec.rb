RSpec.describe Gloomhaven::CHARACTERS do
  subject(:characters) { Gloomhaven::CHARACTERS }

  it { expect(characters.length).to eq(17) }
  
  describe 'hand_size' do
    let(:hand_sizes) { characters.map { |c| c['hand_size'] } }
    it { expect(hand_sizes.all? { |n| !n.nil? }).to eq true }
  end

  describe 'health_scale' do
    let(:health_scales) { characters.map { |c| c['health_scale'] } }
    it { expect(health_scales.all? { |n| !n.nil? }).to eq true }
  end

  describe 'hex_color' do
    let(:hex_colors) { characters.map { |c| c['hex_color'] } }
    it { expect(hex_colors.all? { |n| !n.nil? }).to eq true }
  end

  describe 'number' do
    let(:numbers) { characters.map { |c| c['number'] } }
    it { expect(numbers.all? { |n| !n.nil? }).to eq true }
    it { expect(numbers).to eq(numbers.uniq) }
  end
end


