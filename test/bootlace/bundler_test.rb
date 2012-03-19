require File.expand_path("../../../lib/bootlace/bundler", __FILE__)
require 'test_helper'

class BootstrapBundler
  include Bootlace::Bundler
end

class BundlerTest < Test::Unit::TestCase
  include TestHelpers

  attr_accessor :bootstrap

  def setup
    @bootstrap = BootstrapBundler.new
  end

  def test_bundles_when_content_out_of_date
    bootstrap.stubs(:get_bundle_checksum).returns("foobar")
    File.stubs(:read).with(".bundle/checksum").returns("barbaz")
    bootstrap.expects(:system).with("bundle install --quiet")
    bootstrap.bundler
    assert_match /Bundling/, last_log
  end

  def test_does_not_bundle_when_content_out_of_date
    bootstrap.stubs(:get_bundle_checksum).returns("foobar")
    File.stubs(:read).with(".bundle/checksum").returns("foobar")
    bootstrap.bundler
    assert_match /Bundle up-to-date; not bundling/, last_log
  end
end
