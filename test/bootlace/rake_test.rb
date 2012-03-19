require File.expand_path("../../../lib/bootlace/rake", __FILE__)
require 'test_helper'

class BootstrapRake
  include Bootlace::Rake
end

class RakeTest < Test::Unit::TestCase
  include TestHelpers

  attr_accessor :bootstrap

  def setup
    @bootstrap = BootstrapRake.new
  end

  def test_rake_task_no_gemfile
    File.stubs(:exist?).with('Gemfile').returns(false)
    bootstrap.expects(:system).with("rake foo:bar:baz")
    bootstrap.rake "foo:bar:baz"
    assert_match /Executing rake task 'foo:bar:baz'/, last_log
  end

  def test_rake_task_with_gemfile
    File.stubs(:exist?).with('Gemfile').returns(true)
    bootstrap.expects(:system).with("bundle exec rake foo:bar:baz")
    bootstrap.rake "foo:bar:baz"
    assert_match /Executing rake task 'foo:bar:baz'/, last_log
  end

  def test_rake_task_with_environment
    bootstrap.stubs(:system).returns(0)
    bootstrap.rake "foo:bar:baz", environment: { "SOMEOPT" => "SET" }
    assert_equal "SET", ENV['SOMEOPT']
  end
end
