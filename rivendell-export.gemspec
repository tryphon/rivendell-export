# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rivendell/export/version'

Gem::Specification.new do |spec|
  spec.name          = "rivendell-export"
  spec.version       = Rivendell::Export::VERSION
  spec.authors       = ["Alban Peignier", "Florent Peyraud"]
  spec.email         = ["alban@tryphon.eu", "florent@tryphon.eu"]
  spec.summary       = %q{Export sound from your Rivendell system}
  spec.description   = %q{Export tool for Rivendell}
  spec.homepage      = "http://projects.tryphon.eu/projects/rivendell-export/"
  spec.license       = "GPL v3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '~> 3.2.8'
  spec.add_runtime_dependency 'rivendell-db'
  spec.add_runtime_dependency 'rsox-command'
  spec.add_runtime_dependency 'trollop'
  spec.add_runtime_dependency 'progressbar'
  
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"

end
