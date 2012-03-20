require_relative 'logger'
require_relative 'os'

module Bootlace
  module Package
    include Bootlace::OS
    include Bootlace::Logger

    attr_reader :noop

    def noop!
      @noop = true
    end

    def package(arg)
      case arg.class.name
      when "String"
        install_package_from_string arg
      when "Hash"
        install_package_from_hash arg
      end
    end

    def install_package_from_string(s)
      unless package_installed? s
        if noop
          logger.info("Would have installed package '#{s}' via #{package_manager}")
        else
          logger.info("Installing package '#{s}' via #{package_manager}")
          install_package s
        end
      else
        logger.info("Package '#{s}' already installed; skipping")
      end
    end

    def install_package_from_hash(hash)
      unless package_installed? hash[os]
        if noop
          logger.info("Would have installed package '#{hash[os]}' via #{package_manager}")
        else
          logger.info("Installing package '#{hash[os]}' via #{package_manager}")
          install_package hash[os]
        end
      else
        logger.info("Package '#{hash[os]}' already installed; skipping")
      end
    end

    private
    def install_package(name)
      system [
        os == :mac ? "" : "sudo",
        package_manager,
        "install",
        name
      ].join(" ").strip
    end

    def package_installed?(name)
      case os
      when :mac
        system "brew list | grep #{name} > /dev/null"
      when :ubuntu
        system "sudo aptitude show #{name} | grep installed > /dev/null"
      when :debian
        system "sudo aptitude show #{name} | grep installed > /dev/null"
      when :centos
        system "sudo yum list #{name} | grep installed > /dev/null"
      end
      $? == 0 ? true : false
    end

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
