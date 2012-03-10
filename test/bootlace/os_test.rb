require File.expand_path("../../../lib/bootlace/os", __FILE__)
require 'test_helper'

class BootstrapOS
  include Bootlace::OS
end

class OsTest < Test::Unit::TestCase
  include TestHelpers
  
  attr_accessor :bootstrap

  def setup
    @bootstrap = BootstrapOS.new
  end

  def test_os_when_mac
    with_constants RUBY_PLATFORM: 'darwin' do
      assert_equal :mac, bootstrap.os
    end
  end

  def test_os_when_centos
    with_constants RUBY_PLATFORM: 'linux' do
      File.expects(:exist?).with('/etc/redhat-release').returns(true)
      assert_equal :centos, bootstrap.os
    end
  end

  def test_os_when_ubuntu
    with_constants RUBY_PLATFORM: 'linux' do
      File.expects(:exist?).with('/etc/redhat-release').returns(false)
      File.expects(:exist?).with('/etc/debian_version').returns(false)
      File.expects(:exist?).with('/etc/ubuntu_version').returns(true)
      assert_equal :ubuntu, bootstrap.os
    end
  end

  def test_os_when_debian
    with_constants RUBY_PLATFORM: 'linux' do
      File.expects(:exist?).with('/etc/redhat-release').returns(false)
      File.expects(:exist?).with('/etc/debian_version').returns(true)
      assert_equal :debian, bootstrap.os
    end
  end

  def test_when_linux_but_unsupported
    with_constants RUBY_PLATFORM: 'linux' do
      File.expects(:exist?).with('/etc/redhat-release').returns(false)
      File.expects(:exist?).with('/etc/debian_version').returns(false)
      File.expects(:exist?).with('/etc/ubuntu_version').returns(false)
      assert_equal :unsupported, bootstrap.os
    end
  end

  def test_os_unsupported
    with_constants RUBY_PLATFORM: 'win32' do
      assert_equal :unsupported, bootstrap.os
    end
  end
end
