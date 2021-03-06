# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multiple_man_sidekiq/version'

Gem::Specification.new do |spec|
  spec.name          = "multiple_man_sidekiq"
  spec.version       = MultipleManSidekiq::VERSION
  spec.authors       = ["Ryan Brunner"]
  spec.email         = ["ryan@influitive.com"]
  spec.summary       = %q{Sidekiq support for Multiple Man}
  spec.description   = %q{This gem adds support for publishing Multiple Man models asynchronously using Sidekiq}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "sidekiq"
  spec.add_dependency "multiple_man"
end
