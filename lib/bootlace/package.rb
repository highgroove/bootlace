require 'logger'
require_relative 'os'

module Bootlace
  module Package
    include Bootlace::OS

    attr_reader :noop, :logger

    def initialize_logger
      @logger ||= ::Logger.new(STDOUT)
      set_logger_format
    end

    def noop!
      @noop = true
      @logger = ::Logger.new('/tmp/bootlace.log')
      set_logger_format
    end

    def package(arg)
      case arg.class.name
      when "String"
        case os
        when :mac
          if noop
            logger.info("Would have installed package '#{arg}' via #{package_manager}")
          else
            logger.info("Installing package '#{arg}' via #{package_manager}")
            install_package arg
          end
        end
      when "Hash"
        if noop
          logger.info("Would have installed package '#{arg[os]}' via #{package_manager}")
        else
          logger.info("Installing package '#{arg[os]}' via #{package_manager}")
          install_package arg[os]
        end
      end
    end

    def install_package(name)
    end

    private
    def set_logger_format
      logger.formatter = proc do |severity, datetime, progname, msg|
          "[#{progname}] #{severity}: #{msg}\n"
      end
    end

    def package_manager
      {
        mac: 'brew',
        ubuntu: 'apt',
        debian: 'apt',
        centos: 'yum'
      }.fetch(os)
    end
  end
end
