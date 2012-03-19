require File.expand_path("../../lib/bootlace", __FILE__)
require_relative 'test_helper.rb'

class Bootstrap
  include Bootlace
end

class BootlaceTest < Test::Unit::TestCase
  include TestHelpers

  attr_accessor :bootstrap

  def setup
    @bootstrap = Bootstrap.new
  end

  def test_reality
    bootstrap.stubs(:system).returns(0)
    bootstrap.bundler
    bootstrap.rake 'foo'
    bootstrap.package 'bar'
    true
  end
end
