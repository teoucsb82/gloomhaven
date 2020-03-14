require 'yaml'
require 'gloomhaven/version'
require 'gloomhaven/card'
require 'gloomhaven/character'
require 'gloomhaven/deck'
require 'gloomhaven/perk'
require 'gloomhaven/player'

module Gloomhaven
  class CardNotFoundError < StandardError; end

  CARDS = YAML.load(File.read(File.join(File.dirname(__FILE__), '../config/cards.yml')))
  CHARACTERS = YAML.load(File.read(File.join(File.dirname(__FILE__), '../config/characters.yml'))).sort_by { |c| c['number'] }
  PERKS = YAML.load(File.read(File.join(File.dirname(__FILE__), '../config/perks.yml')))

  CHARACTER_NAMES = CHARACTERS.map { |character| character['name'] }
  
  def self.version
    VERSION
  end
end
