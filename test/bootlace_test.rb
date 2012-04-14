require File.expand_path("../../lib/bootlace", __FILE__)
require_relative 'test_helper.rb'

class BootlaceTest < Test::Unit::TestCase
  include TestHelpers

  def test_reality
    Bootlace.strap_up do |b|
      assert_equal b, Bootlace.base
    end
  end
end
