# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gmd/version"

Gem::Specification.new do |s|
  s.name        = "gmd"
  s.version     = Gmd::VERSION
  s.authors     = ["MOZGIII"]
  s.email       = ["mike-n@narod.ru"]
  s.homepage    = ""
  s.summary     = %q{gmd is a small command-line utility to easily generate fancy HTML from Markdown.}
  s.description = %q{gmd is a small command-line utility to easily generate fancy HTML from Markdown.}

  s.rubyforge_project = "gmd"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "redcarpet"
  s.add_runtime_dependency "tilt"
end
