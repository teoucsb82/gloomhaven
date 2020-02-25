module Gloomhaven
  class Card
    attr_reader :attack
    attr_reader :crit
    attr_reader :name
    attr_reader :miss
    attr_reader :shuffle

    # returns a card object from the card name
    def self.find(name)
      Card.new(find_id_by_name(name))
    end

    def initialize(number)
      validate_card_number!(number)

      data = CARDS[number]
      @name = data['name']
      @attack = data['attack']
      @crit = data['crit'] == true
      @miss = data['miss'] == true
      @shuffle = data['shuffle'] == true
    end

    def bless?
      name.downcase == 'bless'
    end

    def curse?
      name.downcase == 'curse'
    end

    def to_s
      name
    end

    private

    # returns yaml-id of the card by name
    def self.find_id_by_name(name)
      CARDS.select { |id, attributes| attributes['name'].downcase == name.downcase }.keys.first
    end

    def validate_card_number!(number)
      raise ArgumentError.new('Number must be an integer') unless number.is_a?(Integer)
      raise ArgumentError.new('Number is not supported') unless Gloomhaven::CARDS.keys.include?(number)
    end
  end
end