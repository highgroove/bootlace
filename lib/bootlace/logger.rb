require 'logger'

module Bootlace
  module Logger
    def logger
      if ENV["TEST"]
        @logger ||= ::Logger.new('/tmp/bootlace.log')
      else
        @logger ||= ::Logger.new(STDOUT)
      end

      @logger.formatter = proc do |severity, datetime, progname, msg|
        "[bootlace] #{severity}: #{msg}\n"
      end

      @logger
    end
  end
end
