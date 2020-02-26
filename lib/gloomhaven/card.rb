module Gloomhaven
  class Card
    attr_reader :attack, :crit, :miss, :name, :shuffle

    # returns a card object from the card name
    def self.find(name)
      card_id = CARDS.select { |id, attributes| attributes['name'].downcase == name.downcase }.keys.first
      Card.new(card_id)
    end

    def initialize(number)
      validate_card_number!(number)

      data = CARDS[number]
      @name = data['name']
      @attack = data['attack']
      @crit = data['crit'] == true
      @miss = data['miss'] == true
      @rolling = data['rolling'] == true
      @shuffle = data['shuffle'] == true
    end

    def bless?
      name.downcase == 'bless'
    end

    def curse?
      name.downcase == 'curse'
    end

    def rolling?
      @rolling
    end

    private

    def validate_card_number!(number)
      raise ArgumentError.new('Number must be an integer') unless number.is_a?(Integer)
      raise ArgumentError.new('Number is not supported') unless Gloomhaven::CARDS.keys.include?(number)
    end
  end
end