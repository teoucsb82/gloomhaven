RSpec.describe Gloomhaven::CHARACTERS do
  subject(:characters) { Gloomhaven::CHARACTERS }

  it { expect(characters.length).to eq(17) }
  
  describe 'number' do
    let(:numbers) { characters.map { |c| c['number'] } }

    it 'has a number for each character' do
      expect(numbers.all? { |n| !n.nil? }).to eq true
    end

    it 'has no duplicate numbers' do
      expect(numbers).to eq(numbers.uniq)
    end
  end
end


