module Gloomhaven
  class Perk
    attr_reader :description, :effects, :key

    def initialize(key)
      validate!(key)

      data = PERKS[key]
      @key = key
      @description = data['description']
      @effects = data['effects']
    end

    ##
    # returns a hash of card objects
    # Ex: Perk.new.carsd
    # => { add: [Card, Card], remove: [Card, Card, Card] }
    def cards
      result = { 'add' => [], 'remove' => [] }
      return result unless effects

      effects.each do |effect|
        card_name = effect['card_name']
        count = effect['count']
        count.times { result['add'] << Card.find(card_name) } if effect['add']
        count.times { result['remove'] << Card.find(card_name) } if effect['remove']
      end
      result
    end

    private

    def validate!(key)
      raise TypeError.new("Perk #{key} is not supported") unless PERKS[key]
    end
  end
end