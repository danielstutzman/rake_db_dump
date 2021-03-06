# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake_db_dump/version'

Gem::Specification.new do |spec|
  spec.name          = "rake_db_dump"
  spec.version       = RakeDbDump::VERSION
  spec.authors       = ["Daniel Stutzman"]
  spec.email         = ["dtstutz@gmail.com"]
  spec.description   = "Provides a rake db:dump task so no SQL client is needed"
  spec.summary       = "Provides a rake db:dump task so no SQL client is needed"
  spec.homepage      = "https://github.com/danielstutzman/rake_db_dump"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
