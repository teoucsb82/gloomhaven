require 'yaml'
require 'gloomhaven/version'
require 'gloomhaven/card'
require 'gloomhaven/deck'
require 'gloomhaven/player'
require 'gloomhaven/perk'

module Gloomhaven
  class CardNotFoundError < StandardError; end

  CARDS = YAML.load(File.read(File.join(File.dirname(__FILE__), '../config/cards.yml')))
  CHARACTERS = YAML.load(File.read(File.join(File.dirname(__FILE__), '../config/characters.yml')))
  PERKS = YAML.load(File.read(File.join(File.dirname(__FILE__), '../config/perks.yml')))

  def self.version
    VERSION
  end
end
