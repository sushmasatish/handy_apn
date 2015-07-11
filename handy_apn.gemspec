# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'handy_apn/version'

Gem::Specification.new do |spec|
  spec.name          = "handy_apn"
  spec.authors       = ["Sushma Satish"]
  spec.email         = ["sushmasatish@gmail.com"]
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/sushmasatish/handy_apn"
  spec.version       = HandyApn::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.summary       = %q{Provides a handy tool to check your certificate and send apple push notification instantly.}
  spec.description   = %q{Once the Apple push notification certificates are created, use the rake task to send push notification to the device instantly.}
  
  spec.add_dependency "configatron"
  spec.add_dependency "coloured_logger"
  spec.add_dependency "commander", "~> 4.1"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|docs)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths  = ["lib"]

end
