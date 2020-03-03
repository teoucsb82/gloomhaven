require 'yaml'
require 'gloomhaven/version'
require 'gloomhaven/card'
require 'gloomhaven/deck'
require 'gloomhaven/player'
require 'gloomhaven/perk'

module Gloomhaven
  class CardNotFoundError < StandardError; end

  CARDS = YAML.load(File.read('lib/config/cards.yml'))
  CHARACTERS = YAML.load(File.read('lib/config/characters.yml'))
  PERKS = YAML.load(File.read('lib/config/perks.yml'))

  def self.version
    VERSION
  end
end
