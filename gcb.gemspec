# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gcb/version'

Gem::Specification.new do |spec|
  spec.name          = "gcb"
  spec.version       = Gco::VERSION
  spec.authors       = ["Fredrik Persen Fostvedt"]
  spec.email         = ["fpfostvedt@gmail.com"]
  spec.summary       = %q{git checkout +}
  spec.description   = %q{git checkout +}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['gcb']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
