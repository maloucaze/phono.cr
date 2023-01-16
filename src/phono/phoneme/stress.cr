module Phono
  struct Phoneme
    # All the types of stress of a phoneme.
    enum Stress : UInt8
      # Denotes a phoneme with no stress.
      None

      # Denotes a phoneme with primary stress.
      Primary

      # Denoites a phoneme with secondary stress.
      Secondary
    end
  end
end
