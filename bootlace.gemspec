# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bootlace/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Will Farrington"]
  gem.email         = ["will@highgroove.com"]
  gem.description   = %q{Simple gem for bootstrapping Ruby applications}
  gem.summary       = %q{A simple gem for bootstrapping Ruby applications based upon the GitHub script/bootstrap model, but with a tiny DSL on top.}
  gem.homepage      = "https://github.com/highgroove/bootlace"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "bootlace"
  gem.require_paths = ["lib"]
  gem.version       = Bootlace::VERSION

  gem.add_development_dependency('mocha')
  gem.add_development_dependency('activesupport')
  gem.add_development_dependency('minitest-display')
  gem.add_development_dependency('pry')
end
