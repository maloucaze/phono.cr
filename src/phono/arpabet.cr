require "./arpabet/parser"
require "./phoneme"

# A module to handle ARPABET strings.
module Phono::ARPABET
  # The vowel codes of ARPABET.
  VOWELS = Set{
    "AA", "AE", "AH", "AO", "AW", "AX", "AXR", "AY", "EH", "ER", "EY", "IH",
    "IX", "IY", "OW", "OY", "UH", "UW", "UX"
  }

  # The consonant codes of ARPABET.
  CONSONANTS = Set{
    "B", "CH", "D", "DH", "DX", "EL", "EM", "EN", "F", "G", "HH", "JH", "K",
    "L", "M", "N", "NG", "NX", "P", "Q", "R", "S", "SH", "T", "TH", "V", "W",
    "WH", "Y", "Z", "ZH"
  }

  # The entire set of codes of ARPABET.
  ALPHABET = VOWELS + CONSONANTS

  # Parses a string of ARPABET phoneme codes.
  #
  # If `strict_stress` is set to `false`, the method will consider vowel codes
  # without a stress mark (0 for no stress, 1 for primary stress, or 2 for
  # secondary stress) to be a valid ARPABET code and will mark the vowel phoneme
  # as having no stress (0) by default; otherwise, it will raise an exception
  # when it finds such vowel codes.
  def self.parse(str : String, strict_stress = true) : Array(Phoneme)
    Parser.new(str, strict_stress).parse
  end
end
