require 'logger'

module Bootlace
  module Logger
    attr_reader :logger

    if ENV["TEST"]
      @logger = ::Logger.new('/tmp/bootlace.log')
    else
      @logger = ::Logger.new(STDOUT)
    end
    set_logger_format

    private
    def set_logger_format
      logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{progname}] #{severity}: #{msg}\n"
      end
    end
  end
end
