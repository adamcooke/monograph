require 'redcarpet'
require 'pygments'
require 'yaml'
require 'erb'
require 'sass'

require 'monograph/version'
require 'monograph/book'
require 'monograph/chapter'
require 'monograph/export'
require 'monograph/template_context'
require 'monograph/chapter_template_context'
require 'monograph/book_template_context'
require 'monograph/markdown_renderer'
require 'monograph/cli'

module Monograph
  
  def self.root
    File.expand_path('../../', __FILE__)
  end
  
end