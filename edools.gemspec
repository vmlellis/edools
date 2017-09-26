# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edools/version'

Gem::Specification.new do |spec|
  spec.name          = 'edools'
  spec.version       = Edools::VERSION
  spec.authors       = ['Victor Lellis']
  spec.email         = ['vmlellis@gmail.com']

  spec.summary       = 'Gem para a integração da plataforma Edools'
  spec.description   = 'Integração com a Rest API da Edools'
  spec.homepage      = 'http://edools.com/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'faraday', '~> 0.13'
  spec.add_development_dependency 'faraday_middleware', '~> 0.12'
  spec.add_development_dependency 'typhoeus', '~> 1.3'
  spec.add_development_dependency 'oj', '~> 3.3'
  spec.add_development_dependency 'rubocop', '~> 0.50'
end
