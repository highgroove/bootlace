require "bootlace/version"
require "bootlace/logger"
require "bootlace/os"
require "bootlace/package"
require "bootlace/rake"
require "bootlace/bundler"

module Bootlace
  include Bootlace::OS
  include Bootlace::Logger
  include Bootlace::Package
  include Bootlace::Rake
  include Bootlace::Bundler
end
