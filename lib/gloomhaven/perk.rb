module Gloomhaven
  class Perk
    attr_reader :adds, :description, :key, :removes

    def initialize(key)
      validate!(key)

      perk_hash = PERKS[key]
      @key = key
      @description = perk_hash['description']
      @adds = perk_hash['add'] || []
      @removes = perk_hash['remove'] || []
    end

    ##
    # returns a hash of card objects
    # Ex: Perk.new.cards
    # => { add: [Card, Card], remove: [Card, Card, Card] }
    def cards
      result = { 'add' => [], 'remove' => [] }
      adds.each { |effect| result['add'] = 1.upto(effect['count']).map { Card.new(effect['card_name']) } }
      removes.each { |effect| result['remove'] = 1.upto(effect['count']).map { Card.new(effect['card_name']) } }
      result
    end

    private

    def validate!(key)
      raise TypeError.new("Perk #{key} is not supported") unless PERKS[key]
    end
  end
end