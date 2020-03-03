# Gloomhaven

Ruby gem for generating Gloomhaven characters and ability decks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gloomhaven'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gloomhaven

## Usage

### Basic useage

#### Deck
Create a `Gloomhaven::Deck` `@deck` object to create a standard 20-`Gloomhaven::Card` modifier deck.

```
require 'gloomhaven'

@deck = Gloomhaven::Deck.new
=> #<Gloomhaven::Deck>

# shuffle the deck to start
@deck.shuffle!

@deck.cards.count
=> 20

# draw some cards
@deck.draw
=> #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>

# check the deck size, it's decreased
@deck.cards.count
=> 19

# Let's bless and curse the deck
# Note that blessing/cursing a deck will automatically reshuffle the remaining (undrawn) cards.
@deck.bless!
@deck.curse!

# confirm we added two new cards
@deck.cards.count
=> 21

# let's shuffle the deck again and return the first card we drew
@deck.shuffle!

# final count of a shuffled deck w/ 1 bless, 1 curse
@deck.cards.size
=> 22

# and let's look at the cards
@deck.cards.to_a
[
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -2", @attack=-2, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Bless", @attack=0, @crit=true, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Curse", @attack=0, @crit=false, @miss=true, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +2", @attack=2, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Null", @attack=0, @crit=false, @miss=true, @rolling=false, @shuffle=true>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="2x", @attack=0, @crit=true, @miss=false, @rolling=false, @shuffle=true>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>
]
```

#### Player
Create a `Gloomhaven::Player` `@player` object. Includes attribute tracking for `player#gold`, `player#xp`.

```
@player = Gloomhaven::Player.new(character_class: 'Mindthief', name: 'Ratteo')
=> #<Gloomhaven::Player @name="Ratteo" @gold=0 @xp=0>

# check / set gold
@player.gold
=> 0

@player.gold = 10
=> 10

@player.gold
=> 10

# Note: can do the same attr setting w/ @player.xp
```

New players have a default, 20-card attack modifier `@deck` object.
`@player`s can also add valid perks of class `Gloomhaven::Perk` to directly modify their deck.

```
@player.deck
=> #<Gloomhaven::Deck>

# Basic starting attack modifier deck comes with each player
@player.deck.cards.count
=> 20

# Default characters don't have any perks
@player.perks
=> []

# If we add perks, it will directly modify the deck
# Let's remove two -1 cards
@player.add_perk!(Gloomhaven::Perk.new('remove_two_minus_one_cards'))
 => [#<Gloomhaven::Perk:0x007fc6918989b0 @key="remove_two_minus_one_cards", @description="Remove two -1 cards", @adds=[], @removes=[{"card_name"=>"Attack -1", "count"=>2}]>] 

# And confirm the perks
@player.perks
=> [#<Gloomhaven::Perk:0x007fc6918989b0 @key="remove_two_minus_one_cards", @description="Remove two -1 cards", @adds=[], @removes=[{"card_name"=>"Attack -1", "count"=>2}]>] 

# Finally, the deck should have two less cards because of the perk.
@player.deck.cards.count
=> 18

# Perfect. Let's just double check the cards directly
p @player.deck.cards.to_a
[
  #<Gloomhaven::Card @name="2x", @attack=0, @crit=true, @miss=false, @rolling=false, @shuffle=true>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +0", @attack=0, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +1", @attack=1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack +2", @attack=2, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>, # <-- Note we only have 3x -1 cards now
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -1", @attack=-1, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Attack -2", @attack=-2, @crit=false, @miss=false, @rolling=false, @shuffle=false>,
  #<Gloomhaven::Card @name="Null", @attack=0, @crit=false, @miss=true, @rolling=false, @shuffle=true>
]
```