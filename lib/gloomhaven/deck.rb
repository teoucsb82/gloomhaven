module Gloomhaven
  class Deck
    attr_reader :cards
    attr_reader :drawn_cards

    def initialize
      @cards = []
      @drawn_cards = []
      build_base_deck!
    end

    def add!(card)
      raise TypeError.new('Card must be a Gloomhaven::Card') unless card.is_a?(Gloomhaven::Card)

      @cards << card
      @cards
    end

    def average_attack
      cards.sum(&:attack) / size.to_f
    end

    def bless!
      @cards << Card.find('Bless')
      shuffle!(false)
    end

    def curse!
      @cards << Card.find('Curse')
      shuffle!(false)
    end

    def draw
      card = @cards.shift
      @drawn_cards << card unless card.bless? || card.curse?
      card
    end

    def remove!(card)
      raise TypeError.new('Card must be a Gloomhaven::Card') unless card.is_a?(Gloomhaven::Card)

      index = cards.index { |c| c.name == card.name }
      raise ArgumentError.new("Card: '#{card.name}' not found in deck") unless index

      @cards.delete_at(index)
      @cards
    end

    def shuffle!(full_shuffle = true)
      return @cards.shuffle! unless full_shuffle

      @cards = (@cards + @drawn_cards).shuffle
      @drawn_cards = []
      @cards
    end

    def size
      cards.size + @drawn_cards.size
    end

    private

    def build_base_deck!
      CARDS.each do |card|
        id, attributes = card
        attributes['starting_count'].times { cards << Card.new(id) }
      end
    end
  end
end