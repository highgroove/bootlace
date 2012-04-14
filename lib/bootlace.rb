require "bootlace/version"
require "bootlace/logger"
require "bootlace/os"
require "bootlace/package"
require "bootlace/rake"
require "bootlace/bundler"

module Bootlace
  class Base
    include Bootlace::OS
    include Bootlace::Logger
    include Bootlace::Package
    include Bootlace::Rake
    include Bootlace::Bundler

    def rails
      bundler
      rake 'db:create'
      rake 'db:schema:load'
      rake 'db:seed'
      rake 'db:test:prepare'
    end
  end

  def self.base
    @base ||= Bootlace::Base.new
  end
  
  def self.strap_up
    yield base if block_given?
  end
end
