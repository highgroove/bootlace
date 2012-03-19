require_relative 'logger'
require 'digest'

module Bootlace
  module Bundler
    include Bootlace::Logger

    def bundler
      checksum = get_bundle_checksum

      begin
        installed = File.read('.bundle/checksum')
      rescue Errno::ENOENT
        logger.info "No checksum cache file, will bundle."
      end

      unless installed == checksum
        logger.info "Bundling"
        system 'bundle install --quiet'
      else
        logger.info "Bundle up-to-date; not bundling"
      end

      unless Dir.exist? '.bundle'
        Dir.mkdir '.bundle'
      end

      File.open('.bundle/checksum', 'w+') do |f|
        f.write checksum
      end
    end

    private
    def get_bundle_checksum
      md5 = ""
      md5 << File.read('Gemfile')
      md5 << File.read('Gemfile.lock')
      Digest::MD5.hexdigest md5
    end
  end
end
