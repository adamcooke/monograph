module Monograph
  class MarkdownRenderer < Redcarpet::Render::HTML
    
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
    
    def paragraph(text)
      klass = ''
      text.gsub!(/\A\[([A-Z]+)\]/) do
        klass = " class='#{$1.downcase}'"
        ''
      end
      "<p#{klass}>#{text}</p>"
    end
    
    # Images need positioning ability
    def image(src, title, alt)
      if alt.gsub!(/\*([\w\-\s]+)\z/, '')
        klass = "imgcontainer #{$1}"
      else
        klass = nil
      end
      String.new.tap do |s|
        s << "<span class='#{klass}'>"
        if klass == "imgcontainer captioned"
          s << "<span class='image'><img src='#{src}' title='#{title}' alt='#{alt}'></span>"
          s << "<span class='caption'>#{alt}</span>"
        else
          s << "<img src='#{src}' title='#{title}' alt='#{alt}'>"
        end
        s << "</span>"
      end
    end
    
  end
end
