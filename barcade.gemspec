# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'barcade/version'

Gem::Specification.new do |spec|
  spec.name          = "barcade"
  spec.version       = Barcade::VERSION
  spec.authors       = ["Max Stoller"]
  spec.email         = ["maxstoller@gmail.com"]
  spec.description   = %q{A CLI for Barcade.}
  spec.summary       = %q{A CLI for Barcade.}
  spec.homepage      = "https://github.com/maxstoller/barcade"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "mechanize"
  spec.add_dependency "terminal-table"

  spec.post_install_message = "🍺"
end
