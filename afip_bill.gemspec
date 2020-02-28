# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'afip_bill/version'

Gem::Specification.new do |s|
  s.name          = "afip_bill"
  s.version       = AfipBill::VERSION
  s.authors       = ["Luciano Becerra", "Mauro Otonelli"]
  s.email         = ["luciano@ombulabs.com"]

  s.summary       = "AFIP PDF bill"
  s.description   = "Allows you to generate an AFIP bill in PDF format"
  s.homepage      = "http://github.com/ombulabs/afip_bill"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|s|features)/})
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.13"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "pry-byebug", "~> 3.4.0"

  s.add_dependency "barby", "~> 0.6.2"
  s.add_dependency "pdfkit", "~> 0.8.2"
end
