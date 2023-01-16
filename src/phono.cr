require "./phono/arpabet"
require "./phono/ipa"

module Phono
  VERSION = "0.1.0"

  # Transcription table from ARPABET to IPA.
  ARPABET_TO_IPA = Hash.zip(ARPABET::ALPHABET.to_a, IPA::ALPHABET.to_a)

  # Transcription table from IPA to ARPABET.
  IPA_TO_ARPABET = Hash.zip(IPA::ALPHABET.to_a, ARPABET::ALPHABET.to_a)
end
