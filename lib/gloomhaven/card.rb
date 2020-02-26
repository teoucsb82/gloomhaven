module Gloomhaven
  class Card

    attr_reader :attack, :crit, :miss, :name, :shuffle

    def initialize(name)
      raise ArgumentError.new('Name must be a string') unless name.is_a?(String)

      card_data = CARDS.detect { |card| card['name'].downcase == name.downcase }
      validate!(card_data)

      @name = card_data['name']
      @attack = card_data['attack']
      @crit = card_data['crit'] == true
      @miss = card_data['miss'] == true
      @rolling = card_data['rolling'] == true
      @shuffle = card_data['shuffle'] == true
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

    def validate!(data)
      raise CardNotFoundError.new unless data
    end
  end
end