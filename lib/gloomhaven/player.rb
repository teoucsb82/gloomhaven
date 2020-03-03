module Gloomhaven
  class Player

    attr_reader :character_class, :name, :deck
    attr_accessor :gold, :items, :perks, :xp

    def initialize(options = { character_class: nil, name: nil } )
      validate!(options)

      @character_class = options[:character_class].downcase
      @deck = Deck.new
      @name = options[:name]
      @gold = 0
      @items = []
      @perks = []
      @xp = 0
    end

    def add_perk!(perk)
      raise TypeError.new('Perk must be a Gloomhaven::Perk') unless perk.is_a?(Gloomhaven::Perk)
      raise ArgumentError.new("#{character_class} cannot select #{perk.description}. Must be one of the following: #{character_class_perks}") unless character_class_perks.include?(perk.key)
      raise ArgumentError.new("#{character_class} has the maximum number of #{perk.description} perks") if existing_perk_count(perk) >= character_perk_limit(perk)
      update_attack_modifier_deck_from!(perk)
      @perks << perk
    end

    private

    def character_class_perks
      CHARACTERS[character_class]['perks'].keys
    end

    def existing_perk_count(perk)
      @perks.count { |p| p.key == perk.key }
    end

    def character_perk_limit(perk)
      CHARACTERS[character_class]['perks'][perk.key]
    end

    def update_attack_modifier_deck_from!(perk)
      perk.cards['add'].each { |card| deck.add!(card) }
      perk.cards['remove'].each { |card| deck.remove!(card) }
    end

    def validate!(options)
      validate_character_class!(options[:character_class])
      validate_name!(options[:name])
    end

    def validate_character_class!(character_class)
      raise ArgumentError.new("options[:character_class] cannot be blank") if character_class.nil?

      unless Gloomhaven::CHARACTERS.keys.include?(character_class.downcase)
        raise TypeError.new("Invalid character_class: #{character_class} is not supported. Must be one of the following: #{Gloomhaven::CHARACTERS.keys}")
      end
    end

    def validate_name!(name)
      raise ArgumentError.new("options[:name] cannot be blank") if name.nil?
      raise ArgumentError.new("options[:name] must be a String") unless name.is_a?(String)
    end
  end
end