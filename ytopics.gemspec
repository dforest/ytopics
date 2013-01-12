# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ytopics/version'

Gem::Specification.new do |gem|
  gem.name          = "ytopics"
  gem.version       = Ytopics::VERSION
  gem.authors       = ["Keita Mori"]
  gem.email         = ["keita011@gmail.com"]
  gem.description   = "View yahoo(.co.jp) topics command."
  gem.summary       = "View yahoo(.co.jp) topics command."
  gem.homepage      = "http://github.com/dforest/ytopics"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
