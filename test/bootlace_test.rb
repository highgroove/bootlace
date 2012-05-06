require File.expand_path("../../lib/bootlace", __FILE__)
require 'test_helper'

class BootlaceTest < MiniTest::Unit::TestCase
  include TestHelpers

  def test_reality
    Bootlace.strap_up do |b|
      assert_equal b, Bootlace.base
    end
  end
end
