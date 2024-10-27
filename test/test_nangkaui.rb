# frozen_string_literal: true

require "test_helper"

class TestNangkaUI < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil(::NangkaUI::VERSION)
  end
end
