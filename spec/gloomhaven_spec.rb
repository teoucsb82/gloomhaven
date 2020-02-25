RSpec.describe Gloomhaven do
  it "has a version number" do
    expect(Gloomhaven::VERSION).not_to be nil
  end

  describe '::CARDS' do
    it { expect(Gloomhaven::CARDS).not_to be nil }
    it { expect(Gloomhaven::CARDS).to be_a(Hash) }
    it { expect(Gloomhaven::CARDS.length).to be > 0 }
  end
end
