require 'minitest/autorun'
require 'csv'

class TestTranscode < Minitest::Test
  def test_transcode_with_multibyte_char
    CSV.generate(encoding: Encoding::Windows_31J) do |csv|
      csv << ["あいう", "え\u2783お"]
      csv << ["かきく", "け\u2783こ\uF941\uF90A"]
      assert_equal csv.encoding, csv.string.encoding
    end
  end

  def test_transcode_only_ascii
    CSV.generate(encoding: Encoding::Windows_31J) do |csv|
      csv << ["a", "b", "c"]
      csv << ["d", "e"]
      assert_equal csv.encoding, csv.string.encoding
    end
  end
end
