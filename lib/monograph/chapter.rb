module Monograph
  class Chapter
    
    attr_reader :book
    attr_reader :path
    
    def initialize(book, path)
      @book = book
      @path = path
    end
    
    def number
      @number ||= permalink.split('-').first.to_i
    end
    
    def permalink
      @permalink ||= @path.split('/').last.gsub(/\.md\z/, '')
    end
    
    def raw
      @raw ||= File.read(File.join(@path))
    end
    
    def html
      @html ||= Kramdown::Document.new(self.raw).to_html
    end
    
    def title
      @title ||= raw =~ /\A\# ([a-z0-9 ]+)$/i ? $1 : 'Unknown'
    end
    
    def template_context
      @template_context ||= TemplateContext.new(self)
    end
    
  end
end
