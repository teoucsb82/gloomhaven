require 'yaml'
require 'gloomhaven/version'
require 'gloomhaven/card'
require 'gloomhaven/deck'

module Gloomhaven
  CARDS = YAML.load(File.read('config/cards.yml'))
  
end
