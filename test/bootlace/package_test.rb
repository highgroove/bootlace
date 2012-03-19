require File.expand_path("../../../lib/bootlace/package", __FILE__)
require 'test_helper'

class BootstrapPackage
  include Bootlace::Package
end

class PackageTest < Test::Unit::TestCase
  include TestHelpers
  
  attr_accessor :bootstrap

  def setup
    @bootstrap      = BootstrapPackage.new
    after_setup_hook
  end

  def after_setup_hook
  end
end

class NoopPackageTest < PackageTest
  def after_setup_hook
    bootstrap.noop!
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
    assert_match /Would have installed package 'redis-server' via apt-get/, last_log
  end
end

class RealPackageTest < PackageTest
  def test_package_without_hash_defaults_to_current_platform
    bootstrap.stubs(:os).returns(:mac)
    bootstrap.expects(:system).with('brew install redis').returns(0)
    bootstrap.package 'redis'
  end

  def test_accepts_hash_of_package_names_mac
    bootstrap.stubs(:os).returns(:mac)
    bootstrap.expects(:system).with('brew install redis').returns(0)
    bootstrap.package mac: 'redis', ubuntu: 'redis-server'
  end

  def test_accepts_hash_of_package_names_ubuntu
    bootstrap.stubs(:os).returns(:ubuntu)
    bootstrap.expects(:system).with('sudo apt-get install redis-server').returns(0)
    bootstrap.package mac: 'redis', ubuntu: 'redis-server'
  end

  def test_accepts_hash_of_package_names_debian
    bootstrap.stubs(:os).returns(:debian)
    bootstrap.expects(:system).with('sudo apt-get install redis-server').returns(0)
    bootstrap.package mac: 'redis', debian: 'redis-server'
  end

  def test_accepts_hash_of_package_names_debian
    bootstrap.stubs(:os).returns(:centos)
    bootstrap.expects(:system).with('sudo yum install redis-server').returns(0)
    bootstrap.package mac: 'redis', centos: 'redis-server'
  end
end
