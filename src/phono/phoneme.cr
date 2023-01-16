require "./arpabet"
require "./phoneme/stress"

module Phono
  # An abstract representation of a phoneme.
  struct Phoneme
    # The ARPABET code for the phoneme.
    @arpabet : String

    # The stress of the phoneme, if any.
    getter stress : Stress?

    def initialize(@arpabet, @stress = nil); end

    # Checks if the phoneme is a consonant.
    def consonant? : Bool
      ARPABET::CONSONANTS.includes?(@arpabet)
    end

    # Checks if the phoneme is a vowel.
    def vowel? : Bool
      ARPABET::VOWELS.includes?(@arpabet)
    end

    # Converts the phoneme to its ARPABET representation.
    def to_arpabet : String
      @arpabet
    end
  end
end
