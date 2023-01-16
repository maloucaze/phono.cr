require "./spec_helper"

describe ARPABET do
  describe ".parse" do
    it "parses an empty string" do
      ARPABET.parse("").should eq [] of Phoneme
    end

    it "fails with a single unknown phoneme" do
      expect_raises(ARPABET::ParseException) do
        ARPABET.parse("AB")
      end
    end

    it "fails with an unknown phoneme among valid phonemes" do
      expect_raises(ARPABET::ParseException) do
        ARPABET.parse(
          "AE AB IY",
          strict_stress: false
        )
      end
    end

    it "parses more than one simple phoneme" do
      result = [
        Phoneme.new(
          arpabet: "AE",
          stress: Phoneme::Stress::None
        ),

        Phoneme.new(arpabet: "B"),

        Phoneme.new(
          arpabet: "IY",
          stress: Phoneme::Stress::None
        )
      ]

      ARPABET.parse(
        "AE B IY",
        strict_stress: false
      ).should eq result
    end

    ARPABET::CONSONANTS.each do |consonant|
      it "parses the simple phoneme #{consonant}" do
        result = [Phoneme.new(arpabet: consonant)]
        ARPABET.parse(consonant).should eq result
      end
    end

    ARPABET::VOWELS.each do |vowel|
      it "parses the simple phoneme #{vowel}" do
        result = [
          Phoneme.new(
            arpabet: vowel,
            stress: Phoneme::Stress::None
          )
        ]

        ARPABET.parse(
          vowel,
          strict_stress: false
        ).should eq result
      end

      it "parses the single vowel phoneme #{vowel}0 (no stress mark)" do
        result = [
          Phoneme.new(
            arpabet: vowel,
            stress: Phoneme::Stress::None
          )
        ]

        ARPABET.parse("#{vowel}0").should eq result
      end

      it "parses the single vowel phoneme #{vowel}1 (primary stress mark)" do
        result = [
          Phoneme.new(
            arpabet: vowel,
            stress: Phoneme::Stress::Primary
          )
        ]

        ARPABET.parse("#{vowel}1").should eq result
      end

      it "parses the single vowel phoneme #{vowel}2 (secondary stress mark)" do
        result = [
          Phoneme.new(
            arpabet: vowel,
            stress: Phoneme::Stress::Secondary
          )
        ]

        ARPABET.parse("#{vowel}2").should eq result
      end
    end

    it "parses a string with all types of stress" do
      result = [
        Phoneme.new(
          arpabet: "AA",
          stress: Phoneme::Stress::None
        ),

        Phoneme.new(arpabet: "B"),

        Phoneme.new(
          arpabet: "AE",
          stress: Phoneme::Stress::Primary
        ),

        Phoneme.new(arpabet: "CH"),

        Phoneme.new(
          arpabet: "AXR",
          stress: Phoneme::Stress::Secondary
        ),
      ]

      ARPABET.parse("AA0 B AE1 CH AXR2").should eq result
    end

    context "with strict_stress = true" do
      it "fails with unmarked stress vowel code" do
        expect_raises(ARPABET::ParseException) do
          ARPABET.parse("AA")
        end
      end
    end

    context "with strict_stress = false" do
      it "allows unmarked stress vowel code" do
        result = [
          Phoneme.new(
            arpabet: "AA",
            stress: Phoneme::Stress::None
          )
        ]

        ARPABET.parse(
          "AA",
          strict_stress: false
        ).should eq result
      end
    end
  end
end
