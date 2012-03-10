require File.expand_path("../../../lib/bootlace/package", __FILE__)
require 'test_helper'

class BootstrapPackage
  include Bootlace::Package
end

class PackageTest < Test::Unit::TestCase
  include TestHelpers
  
  attr_accessor :bootstrap

  def setup
    @bootstrap = BootstrapPackage.new
    @bootstrap.noop!
  end

  def test_package_without_hash_defaults_to_current_platform
    bootstrap.package 'redis'
    assert_match /Would have installed package 'redis' via brew/, last_log
  end

  def test_accepts_hash_of_package_names
    bootstrap.stubs(:os).returns(:mac)
    bootstrap.package mac: 'redis', ubuntu: 'redis-server'
    assert_match /Would have installed package 'redis' via brew/, last_log

    bootstrap.stubs(:os).returns(:ubuntu)
    bootstrap.package mac: 'redis', ubuntu: 'redis-server'
    assert_match /Would have installed package 'redis-server' via apt/, last_log
  end

  private
  def last_log
    IO.readlines("/tmp/bootlace.log").last
  end
end
