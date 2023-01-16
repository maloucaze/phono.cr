# phono.cr

**phono.cr** is a [Crystal](https://crystal-lang.org/) library to parse and
convert between [ARPABET](https://en.wikipedia.org/wiki/ARPABET)/[IPA](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet)
strings.

### Note

> 🚧 This is a work in progress. 🚧

As of now, only parsing ARPABET strings is possible.

#### TODO

- Implement parser for IPA strings
- Implement conversion between ARPABET and IPA
- Possible support for other ARPABET auxiliary symbols (only stress markers are
supported)

## Install

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  phono:
    github: maloucaze/phono.cr
```

2. Run `shards install`

## Usage

Require the shard as follows:

```cr
require "phono"
```

### Parsing ARPABET

```cr
phonemes = Phono::ARPABET.parse("AE0 B D AA1 M AH0 N AH0 L") # "ABDOMINAL"
# => [
#      Phono::Phoneme(@arpabet="AE", @stress=None),
#      Phono::Phoneme(@arpabet="B", @stress=nil),
#      Phono::Phoneme(@arpabet="D", @stress=nil),
#      Phono::Phoneme(@arpabet="AA", @stress=Primary),
#      Phono::Phoneme(@arpabet="M", @stress=nil),
#      Phono::Phoneme(@arpabet="AH", @stress=None),
#      Phono::Phoneme(@arpabet="N", @stress=nil),
#      Phono::Phoneme(@arpabet="AH", @stress=None),
#      Phono::Phoneme(@arpabet="L", @stress=nil)
#    ]

# Inspect phoneme properties
phonemes[0].consonant? # => false
phonemes[0].vowel?     # => true
phonemes[0].to_arpabet # => "AE0"
```

## Contributors

- [Nick Maloucaze](https://github.com/maloucaze) - creator and maintainer