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