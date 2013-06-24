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
      @raw ||= File.open(File.join(@path), 'rb', &:read)
    end
    
    def html
      @html ||= begin
        rc = Redcarpet::Markdown.new(MarkdownRenderer.new(:with_toc_data => true), :fenced_code_blocks => true)
        rc.render(self.raw)
      end
    end
    
    def title
      @title ||= raw =~ /\A\# ([a-z0-9 \&\,\(\)]+)$/i ? $1 : 'Unknown'
    end
    
    def template_context
      @template_context ||= ChapterTemplateContext.new(self)
    end
    
    def sections(level = 2)
      items = self.html.scan(/<h#{level} id=\"([a-z0-9\-\_]+)\">(.*?)<\/h#{level}>/m)
      items.inject({}) do |hash, match|
        hash[match[0]] = match[1]
        hash
      end
    end
    
  end
end
