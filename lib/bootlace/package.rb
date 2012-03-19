require_relative 'logger'
require_relative 'os'

module Bootlace
  module Package
    include Bootlace::OS
    include Bootlace::Logger

    attr_reader :noop

    def noop!
      @noop = true
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
      system [
        os == :mac ? "" : "sudo",
        package_manager,
        "install",
        name
      ].join(" ").strip
    end

    private
    def package_manager
      {
        mac: 'brew',
        ubuntu: 'apt-get',
        debian: 'apt-get',
        centos: 'yum'
      }.fetch(os)
    end
  end
end
