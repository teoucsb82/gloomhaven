module Gloomhaven
  class Player

    attr_reader :character_class, :name, :deck
    attr_accessor :gold, :items, :perks, :xp

    def initialize(options = {})
      validate!(options)

      @character_class = options[:character_class].downcase
      @deck = Deck.new
      @name = options[:name]
      @gold = options[:gold] || 0
      @xp = options[:xp] || 0
      @items = []
      @perks = []
    end

    def add_perk!(perk)
      raise TypeError.new('Perk must be a Gloomhaven::Perk') unless perk.is_a?(Gloomhaven::Perk)
      raise ArgumentError.new("#{character_class} cannot select #{perk.description}. Must be one of the following: #{character_class_perks}") unless character_class_perks.include?(perk.key)
      raise ArgumentError.new("#{character_class} has the maximum number of #{perk.description} perks") if existing_perk_count(perk) >= character_perk_limit(perk)
      update_attack_modifier_deck_from!(perk)
      @perks << perk
    end

    private

    def character
      CHARACTERS.detect { |character| character['name'].downcase == character_class.downcase }
    end

    def character_class_perks
      character['perks'].keys
    end

    def existing_perk_count(perk)
      @perks.count { |p| p.key == perk.key }
    end

    def character_perk_limit(perk)
      character['perks'][perk.key]
    end

    def update_attack_modifier_deck_from!(perk)
      perk.cards['add'].each { |card| deck.add!(card) }
      perk.cards['remove'].each { |card| deck.remove!(card) }
    end

    def validate!(options)
      validate_character_class!(options[:character_class])
      validate_name!(options[:name])
      validate_gold!(options[:gold])
      validate_xp!(options[:xp])
    end

    def validate_character_class!(character_class)
      raise ArgumentError.new("options[:character_class] cannot be blank") if character_class.nil?

      unless Gloomhaven::CHARACTER_NAMES.map(&:downcase).include?(character_class.downcase)
        raise TypeError.new("Invalid character_class: #{character_class} is not supported. Must be one of the following: #{Gloomhaven::CHARACTER_NAMES}")
      end
    end

    def validate_gold!(gold)
      return unless gold
      raise ArgumentError.new("options[:gold] must be an Integer") unless gold.is_a?(Integer)
    end

    def validate_name!(name)
      raise ArgumentError.new("options[:name] cannot be blank") if name.nil?
      raise ArgumentError.new("options[:name] must be a String") unless name.is_a?(String)
    end

    def validate_xp!(xp)
      return unless xp
      raise ArgumentError.new("options[:xp] must be an Integer") unless xp.is_a?(Integer)
    end
  end
end