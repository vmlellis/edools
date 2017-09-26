# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "edools/version"

Gem::Specification.new do |spec|
  spec.name          = "edools"
  spec.version       = Edools::VERSION
  spec.authors       = ["Victor Lellis"]
  spec.email         = ["vmlellis@gmail.com"]

  spec.summary       = %q{Gem para a integração da plataforma Edools}
  spec.description   = %q{Essa gem tem como objetivo integrar com a Rest API da Edools}
  spec.homepage      = "http://edools.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  # spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
