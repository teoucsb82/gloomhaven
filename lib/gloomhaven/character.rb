module Gloomhaven
  class Character
    attr_reader :hand_size, :health_scale, :hex_color, :name, :number, :perks, :spoiler_name

    def initialize(klass)
      validate_class!(klass)
      @klass = klass
      @hand_size = data['hand_size']
      @health_scale = data['health_scale']
      @hex_color = data['hex_color']
      @name = data['name']
      @number = data['number']
      @perks = data['perks']
      @spoiler_name = data['spoiler_name'] || @name
    end

    def to_s
      @name
    end

    private

    def data
      CHARACTERS.detect { |character| character['name'].downcase == @klass.downcase }
    end

    def validate_class!(klass)
      raise ArgumentError.new("Character class must be a String") unless klass.is_a?(String)

      return if Gloomhaven::CHARACTER_NAMES.map(&:downcase).include?(klass.downcase)
        
      raise TypeError.new("Invalid klass: #{klass} is not supported. Must be one of the following: #{Gloomhaven::CHARACTER_NAMES}")
    end
  end
end