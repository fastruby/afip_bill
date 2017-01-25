# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'afip/bill/version'

Gem::Specification.new do |s|
  s.name          = "afip-bill"
  s.version       = Afip::Bill::VERSION
  s.authors       = ["Luciano Becerra"]
  s.email         = ["luciano@ombulabs.com"]

  s.summary       = "AFIP PDF bill"
  s.description   = "Allows you to generate an AFIP bill in PDF format"
  s.homepage      = "http://github.com/ombulabs/afip-bill"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|s|features)/})
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.13"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
end
