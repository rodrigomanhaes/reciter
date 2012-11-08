# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

require 'reciter/version'

Gem::Specification.new do |s|
  s.name = 'reciter'
  s.version = Reciter::VERSION
  s.date = %q{2012-11-08}
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.author = 'Rodrigo Manhães'
  s.description = 'Parses number sequences.'
  s.email = 'rmanhaes@gmail.com'
  s.homepage = 'https://github.com/rodrigomanhaes/reciter'
  s.summary = 'Parses number sequences'
  s.licenses = ["MIT"]

  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ['lib']

  s.files = Dir.glob('lib/**/*.rb') + %w(README.rdoc LICENSE.txt)
  s.add_development_dependency('rspec', '~> 2.11.0')
  s.add_development_dependency('pry')
end
