require 'kramdown'
require 'pygments'
require 'yaml'
require 'erb'

require 'monograph/version'
require 'monograph/book'
require 'monograph/chapter'
require 'monograph/export'
require 'monograph/template_context'

module Monograph
  
  def self.root
    File.expand_path('../../', __FILE__)
  end
  
end