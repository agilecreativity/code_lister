# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "code_lister/version"
Gem::Specification.new do |spec|
  spec.name        = "code_lister"
  spec.version     = CodeLister::VERSION
  spec.authors     = ["Burin Choomnuan"]
  spec.email       = ["agilecreativity@gmail.com"]
  spec.summary     = "List/filter files like 'find then grep' command in Linux/Unix based system"
  spec.description = "List/filter files similar to 'find then grep' command in Linux/Unix based system"
  spec.homepage    = "https://github.com/agilecreativity/code_lister"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 1.9.3"
  spec.files       = Dir.glob("{bin,lib,spec}/**/*") + %w[Gemfile
                                                          Rakefile
                                                          code_lister.gemspec
                                                          README.md
                                                          CHANGELOG.md
                                                          LICENSE
                                                          .rubocop.yml
                                                          .gitignore]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "agile_utils", "~> 0.2.3"
  spec.add_runtime_dependency "thor", "~> 0.19.1"
  spec.add_development_dependency "awesome_print", "~> 1.2.0"
  spec.add_development_dependency "bundler", "~> 1.7.3"
  spec.add_development_dependency "fuubar", "~> 2.0.0"
  spec.add_development_dependency "guard-rspec", "~> 4.3.1"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "rake", "~> 10.3.2"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "rubocop", "~> 0.26.1"
end
