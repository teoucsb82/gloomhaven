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
    # card = Card.new('Attack +3')
    # deck.add!(card)
    def add!(card)
      raise TypeError.new('Card must be a Gloomhaven::Card') unless card.is_a?(Gloomhaven::Card)

      @cards << card
      @cards
    end

    ##
    # Adds a bless card to the current deck, then soft shuffles
    def bless!
      @cards << Card.new('Bless')
      shuffle!(soft_shuffle: true)
    end

    ##
    # Adds a curse card to the current deck, then soft shuffles
    def curse!
      @cards << Card.new('Curse')
      shuffle!(soft_shuffle: true)
    end

    ##
    # Shuffles the deck if trying to draw without any cards left in pile.
    # Removes the top card from the deck, adds it to the @drawn_cards array (unless it's a bless/curse)
    # Returns the drawn card.
    # Ex: Deck.new.draw
    # => #<Card >
    def draw
      shuffle! if @cards.empty?

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
    # card = Card.new('Attack -1')
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
        number = card['starting_count'] || 0
        number.times { cards << Card.new(card['name']) }
      end
    end
  end
end