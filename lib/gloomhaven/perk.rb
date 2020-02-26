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

    private

    def validate!(key)
      raise TypeError.new("Perk #{key} is not supported") unless PERKS[key]
    end
  end
end