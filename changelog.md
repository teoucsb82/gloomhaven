# 1.0.9
- add class Character for character logic
  - moved most of logic from Player to character, add a @character to player initialize, delegate to char
    - player keeps things like gold, xp, items, perks
  - takes in class name
  - Track hand_size, hex_code (color theme for character cards), character number, perks, health_scale

# 1.0.8
- Allow gold, xp
- Update characters yaml to return name, spoiler_name, number. Sort by number

# 1.0.7.1
- Fixed loading issue with pry gem

# 1.0.6
- Updated changelog path
- Added player validations for class, name

# 1.0.5
- Updated error message for Player creation to list valid types

# 1.0.4
- Fixed issues with YAML loading data externally.

# 1.0.0
- Launched w/ all classes, perks, cards from Gloomhaven