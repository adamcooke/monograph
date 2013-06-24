module Monograph
  class ChapterTemplateContext < TemplateContext
    
    attr_reader :chapter
    
    def initialize(chapter)
      @chapter = chapter
    end
    
    def book
      @chapter.book
    end
    
    def page_title
      "#{chapter.title} - #{book.title}"
    end
    
    def content
      @chapter.html
    end
    
    def permalink
      @chapter.permalink + ".html"
    end
    
    def next_page
      @chapter.book.chapters.select { |c| c.number == @chapter.number + 1}.first
    end
    
    def previous_page
      if @chapter.number == 1
        BookTemplateContext.new(@chapter.book, 'contents.html')
      else
        @chapter.book.chapters.select { |c| c.number == @chapter.number - 1}.first
      end
    end
    
  end
end
