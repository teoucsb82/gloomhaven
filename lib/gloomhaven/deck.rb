require 'gloomhaven/card'

module Gloomhaven
  class Deck
    attr_reader :cards
    attr_reader :drawn_cards

    ##
    # Creates a basic 20-card attack deck
    def initialize
      @cards = []
      @drawn_cards = []
      build_base_deck!
    end

    ##
    # Adds a card to the current deck.
    # Useful for updating decks based on character-specific perks.
    # Ex:
    #
    # deck = Deck.new
    # card = Card.find('Attack +3')
    # deck.add!(card)
    def add!(card)
      raise TypeError.new('Card must be a Gloomhaven::Card') unless card.is_a?(Gloomhaven::Card)

      @cards << card
      @cards
    end

    ##
    # Adds a bless card to the current deck, then soft shuffles
    def bless!
      @cards << Card.find('Bless')
      shuffle!(soft_shuffle: true)
    end

    ##
    # Adds a curse card to the current deck, then soft shuffles
    def curse!
      @cards << Card.find('Curse')
      shuffle!(soft_shuffle: true)
    end

    ##
    # Removes the top card from the deck, adds it to the @drawn_cards array (unless it's a bless/curse)
    # Returns the drawn card.
    # Ex: Deck.new.draw
    # => #<Card >
    def draw
      card = @cards.shift
      @drawn_cards << card unless card.bless? || card.curse?
      card
    end

    ##
    # Removes a card from the current deck.
    # Useful for updating decks based on character-specific perks.
    # Ex:
    #
    # deck = Deck.new
    # card = Card.find('Attack -1')
    # deck.remove!(card)
    def remove!(card)
      raise TypeError.new('Card must be a Gloomhaven::Card') unless card.is_a?(Gloomhaven::Card)

      index = cards.index { |c| c.name == card.name }
      raise ArgumentError.new("Card: '#{card.name}' not found in deck") unless index

      @cards.delete_at(index)
      @cards
    end

    ##
    # Randomizes the order of #cards
    # By default, will shuffle all cards together.
    #
    # Can override with `options = { soft_shuffle: true }`  to
    # only shuffle cards not yet drawn (useful for blesses/curses)
    def shuffle!(options = {})
      options[:soft_shuffle] ||= false
      return @cards.shuffle! if options[:soft_shuffle]

      @cards = (@cards + @drawn_cards).shuffle
      @drawn_cards = []
      @cards
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