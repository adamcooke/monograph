desc 'Run the test suite'
task :test do
  $:.unshift File.expand_path('../lib', __FILE__)
  $:.unshift File.expand_path('../test', __FILE__)
  require 'test_helper'
  Dir[File.expand_path('../test/*.rb', __FILE__)].each { |file| require file }
end
