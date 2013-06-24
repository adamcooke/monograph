$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'monograph/version'

Gem::Specification.new do |s|
  s.name = 'monograph'
  s.version = Monograph::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "A beautiful HTML book builder for Markdown"
  s.description = "A command line tool for generating beautiful HTML eBooks from Markdown documents"
  s.files = Dir["**/*"]
  s.add_dependency('redcarpet', '~> 2.2.2')
  s.add_dependency('pygments.rb', '~> 0.5.0')
  s.add_dependency('rake', '~> 10.0.4')
  s.add_dependency('sass', '~> 3.2.9')
  s.bindir = "bin"
  s.require_path = 'lib'
  s.has_rdoc = false
  s.author = "Adam Cooke"
  s.email = "adam@atechmedia.com"
  s.homepage = "http://atechmedia.com"
end
