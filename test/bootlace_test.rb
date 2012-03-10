require File.expand_path("../../lib/bootlace", __FILE__)
require_relative 'test_helper.rb'

class Bootstrap
  include Bootlace
end

class BootlaceTest < Test::Unit::TestCase
  include TestHelpers

  def setup
    @bootstrap = Bootstrap.new
  end

end
