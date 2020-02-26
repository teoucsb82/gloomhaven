require 'yaml'
require 'gloomhaven/version'
require 'gloomhaven/card'
require 'gloomhaven/deck'
require 'gloomhaven/player'
require 'gloomhaven/perk'

module Gloomhaven
  CARDS = YAML.load(File.read('config/cards.yml'))
  CHARACTERS = YAML.load(File.read('config/characters.yml'))
  PERKS = YAML.load(File.read('config/perks.yml'))
end
