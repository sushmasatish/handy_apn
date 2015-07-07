# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'handy_apn/version'

Gem::Specification.new do |spec|
  spec.name          = "handy_apn"
  spec.version       = HandyApn::VERSION
  spec.authors       = ["Sushma Satish"]
  spec.email         = ["sushmasatish@gmail.com"]

  spec.summary       = %q{Provides a handy tool to check your certificate and send apple push notification instantly.}
  spec.description   = %q{Once the Apple push notification certificates are created, use the rake task to send push notification to the device instantly.}
  spec.homepage      = "https://github.com/sushmasatish/handy_apn"

  spec.rubyforge_project = "handy_apn"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "configatron"
  spec.add_dependency "commander", "~> 4.1"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "json"
end
