require_relative 'logger'

module Bootlace
  module Rake
    include Bootlace::Logger

    def rake(task, o = {})
      options = {
        environment: {}
      }.merge(o)

      options[:environment].each do |key,val|
        ENV[key.to_s] = val.to_s
      end

      logger.info("Executing rake task '#{task}'")
      system "#{detect_bundle} rake -s #{task}".strip
    end

    private
    def detect_bundle
      File.exist?('Gemfile') ? "bundle exec" : ""
    end
  end
end
