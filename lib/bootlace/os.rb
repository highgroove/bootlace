module Bootlace
  module OS
    def os
      if RUBY_PLATFORM.downcase.include? 'darwin'
        :mac
      elsif RUBY_PLATFORM.downcase.include? "linux"
        fetch_distribution
      else
        :unsupported
      end
    end

    private
    def fetch_distribution
      if File.exist? '/etc/redhat-release'
        :centos
      elsif File.exist? '/etc/debian_version'
        :debian
      elsif File.exist? '/etc/ubuntu_version'
        :ubuntu
      else
        :unsupported
      end
    end
  end
end
