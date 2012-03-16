# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "parature/version"

Gem::Specification.new do |s|
  s.name        = "parature"
  s.version     = Parature::VERSION
  s.authors     = ["Anton Astashov"]
  s.email       = ["anton.astashov@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "parature"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "json"

  s.add_development_dependency "rspec"
  s.add_development_dependency "ZenTest"
  s.add_development_dependency "autotest-fsevent"
  s.add_development_dependency "autotest-growl"
  s.add_development_dependency "webmock"
end
