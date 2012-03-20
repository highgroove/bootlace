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
    bootstrap.stubs(:package_installed?).returns(false)
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
    bootstrap.stubs(:package_installed?).returns(false)
    bootstrap.expects(:system).with('brew install redis').returns(0)
    bootstrap.package 'redis'
  end

  def test_accepts_hash_of_package_names_mac
    bootstrap.stubs(:os).returns(:mac)
    bootstrap.stubs(:package_installed?).returns(false)
    bootstrap.expects(:system).with('brew install redis').returns(0)
    bootstrap.package mac: 'redis', ubuntu: 'redis-server'
  end

  def test_accepts_hash_of_package_names_ubuntu
    bootstrap.stubs(:os).returns(:ubuntu)
    bootstrap.stubs(:package_installed?).returns(false)
    bootstrap.expects(:system).with('sudo apt-get install redis-server').returns(0)
    bootstrap.package mac: 'redis', ubuntu: 'redis-server'
  end

  def test_accepts_hash_of_package_names_debian
    bootstrap.stubs(:os).returns(:debian)
    bootstrap.stubs(:package_installed?).returns(false)
    bootstrap.expects(:system).with('sudo apt-get install redis-server').returns(0)
    bootstrap.package mac: 'redis', debian: 'redis-server'
  end

  def test_accepts_hash_of_package_names_centos
    bootstrap.stubs(:os).returns(:centos)
    bootstrap.stubs(:package_installed?).returns(false)
    bootstrap.expects(:system).with('sudo yum install redis-server').returns(0)
    bootstrap.package mac: 'redis', centos: 'redis-server'
  end

  def test_does_not_attempt_to_reinstall_already_installed_package_mac
    bootstrap.stubs(:os).returns(:mac)
    bootstrap.expects(:system).with('brew list | grep redis > /dev/null').returns(0)
    bootstrap.package mac: 'redis'
    assert_match /Package 'redis' already installed; skipping/, last_log
  end

  def test_does_not_attempt_to_reinstall_already_installed_package_ubuntu
    bootstrap.stubs(:os).returns(:ubuntu)
    bootstrap.expects(:system).with('sudo aptitude show redis-server | grep installed > /dev/null').returns(0)
    bootstrap.package ubuntu: 'redis-server'
    assert_match /Package 'redis-server' already installed; skipping/, last_log
  end

  def test_does_not_attempt_to_reinstall_already_installed_package_debian
    bootstrap.stubs(:os).returns(:debian)
    bootstrap.expects(:system).with('sudo aptitude show redis-server | grep installed > /dev/null').returns(0)
    bootstrap.package debian: 'redis-server'
    assert_match /Package 'redis-server' already installed; skipping/, last_log
  end

  def test_does_not_attempt_to_reinstall_already_installed_package_centos
    bootstrap.stubs(:os).returns(:centos)
    bootstrap.expects(:system).with('sudo yum list redis-server | grep installed > /dev/null').returns(0)
    bootstrap.package centos: 'redis-server'
    assert_match /Package 'redis-server' already installed; skipping/, last_log
  end
end
