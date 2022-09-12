# frozen_string_literal: true

class StringTest < Minitest::Test
  def test_underscore
    samples = {
      "Bobo" => "bobo",
      "firstNoCap" => "first_no_cap",
      "ABBREV" => "abbrev",
      "ABBREVPlus" => "abbrev_plus",
      "TestUnder" => "test_under",
      "With7Digit" => "with7_digit",
      "test-dash" => "test_dash",
    }

    samples.each do |camel, underscore|
      assert_equal underscore, camel.underscore
    end
  end
end
