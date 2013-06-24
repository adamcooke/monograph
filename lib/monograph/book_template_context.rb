module Monograph
  # The BookTemplateContext is used whenever a non-chapter page (cover, contents) is to be 
  # rendered within the template.
  class BookTemplateContext < TemplateContext
    
    attr_reader :book
    
    def initialize(book, template)
      @book = book
      @template = template
    end
    
    def content
      @content ||= @book.template_file(@template)
    end
    
    def page_title
      title
    end
    
    def title
      case @template
      when 'index.html' then @book.title
      when 'contents.html' then 'Contents'
      end
    end
    
    def author
      @book.config['author']
    end
    
    def permalink
      @template.gsub(/\.html\z/, '')
    end
    
    def next_page
      case @template
      when 'index.html'
        self.class.new(@book, 'contents.html')
      when 'contents.html'
        @book.chapters.first
      end
    end
    
    def previous_page
      case @template
      when 'contents.html'
        self.class.new(@book, 'index.html')
      end
    end
    
  end
end
