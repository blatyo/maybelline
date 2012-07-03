# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "maybelline/version"

Gem::Specification.new do |s|
  s.name        = "maybelline"
  s.version     = Maybelline::VERSION
  s.authors     = ["Allen Madsen"]
  s.email       = ["blatyo@gmail.com"]
  s.homepage    = "http://blatyo.github.com/maybelline"
  s.summary     = %q{Maybe you should start using the maybe monad, stop checking for nil, and be confident}
  s.description = %q{Maybe you should start using the maybe monad, stop checking for nil, and be confident}

  s.rubyforge_project = "maybelline"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  # s.add_runtime_dependency "rest-client"
end
