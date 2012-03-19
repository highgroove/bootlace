require 'test/unit'
require 'mocha'
require 'turn'
require 'pry'

ENV["TEST"] = "true"

module TestHelpers
  require 'active_support/core_ext/kernel'

  def last_log
    IO.readlines("/tmp/bootlace.log").last
  end

  def with_constants(constants, &block)
    saved_constants = {}
    constants.each do |constant, val|
      saved_constants[ constant ] = Object.const_get( constant )
      Kernel::silence_warnings { Object.const_set( constant, val ) }
    end

    begin
      block.call
    ensure
      constants.each do |constant, val|
        Kernel::silence_warnings { Object.const_set( constant, saved_constants[ constant ] ) }
      end
    end
  end
end
