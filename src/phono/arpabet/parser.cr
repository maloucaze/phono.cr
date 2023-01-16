require "./parse_exception"
require "../phoneme/stress"

module Phono::ARPABET
  # A parser for an ARPABET string.
  #
  # Not directly available to the programmer. Use with `ARPABET.parse`.
  class Parser
    # End of code character.
    END_OF_CODE = ' '

    # No stress marker character.
    NO_STRESS = '0'

    # Primary stress marker character.
    PRIMARY_STRESS = '1'

    # Secondary stress marker character.
    SECONDARY_STRESS = '2'

    # The string that is being parsed.
    @str : String

    # Whether no stress marks are required on vowel codes or not.
    @strict_stress : Bool

    # The character currently being parsed.
    @char : Char? = nil

    # List of phonemes extracted from the string.
    @phonemes = [] of Phoneme

    # The current phoneme code being extracted.
    @code = String::Builder.new

    # The current stress being extracted, if any.
    @stress : Phoneme::Stress? = nil

    def initialize(@str, @strict_stress); end

    # Parses the ARPABET string.
    def parse : Array(Phoneme)
      @str.each_char.with_index do |char, i|
        @char = char

        parse_char

        if i + 1 == @str.size || char == END_OF_CODE
          code_str = @code.to_s

          validate_code(code_str)
          validate_stress(code_str)
          add_phoneme(code_str)
          reset
        end
      end

      @phonemes
    end

    private def parse_char : Nil
      case @char
      when NO_STRESS
        @stress = Phoneme::Stress::None
      when PRIMARY_STRESS
        @stress = Phoneme::Stress::Primary
      when SECONDARY_STRESS
        @stress = Phoneme::Stress::Secondary
      when END_OF_CODE
        # nothing
      else
        @code << @char
      end
    end

    private def validate_code(code : String) : Nil
      unless ARPABET::ALPHABET.includes?(code)
        raise ParseException.new("#{code} is not an ARPABET phoneme code")
      end
    end

    private def validate_stress(code : String) : Nil
      if @stress.nil? && ARPABET::VOWELS.includes?(code)
        if @strict_stress
          raise ParseException.new("#{code} needs a stress marker")
        else
          @stress = Phoneme::Stress::None
        end
      end
    end

    private def add_phoneme(code : String) : Nil
      if @stress.nil?
        @phonemes << Phoneme.new(arpabet: code)
      else
        @phonemes << Phoneme.new(arpabet: code, stress: @stress)
      end
    end

    private def reset : Nil
      @code = String::Builder.new
      @stress = nil
    end
  end
end
