module Monograph
  class TemplateContext
    
    def initialize(chapter)
      @chapter = chapter
    end
    
    def book_title
      @chapter.book.title
    end
    
    def chapter_title
      @chapter.title
    end
    
    def chapters
      @chapter.book.chapters
    end
    
    def next_chapter
      @chapter.book.chapters.select { |c| c.number == @chapter.number + 1}.first
    end
    
    def previous_chapter
      @chapter.book.chapters.select { |c| c.number == @chapter.number - 1}.first
    end
    
    def content
      @chapter.html
    end
    
    def get_binding
      binding
    end
    
  end
end
