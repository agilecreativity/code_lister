# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'code_lister/version'

Gem::Specification.new do |spec|
  spec.name          = "code_lister"
  spec.version       = CodeLister::VERSION
  spec.authors       = ["Burin Choomnuan"]
  spec.email         = ["agilecreativity@gmail.com"]
  spec.summary       = %q{Search, filter files easily using the power of ruby}
  spec.description   = %q{List/filter files similar to 'find' command in Linux/Unix based system}
  spec.homepage      = "https://github.com/agilecreativity/code_lister"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "thor"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.2"
  spec.add_development_dependency "awesome_print", "~> 1.2"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "fuubar", "~> 1.3"
end
