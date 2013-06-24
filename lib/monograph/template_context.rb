module Monograph
  class TemplateContext
    
    def book
    end
    
    # This title will be displayed in the <title> attribute on the page.
    def page_title
    end
    
    # This must return either nil or an object which responds to 'permalink' and 'title'.    
    def previous_page
    end
    
    # This must return either nil or an object which responds to 'permalink' and 'title'.
    def next_page
    end
    
    def get_binding
      binding
    end
    
  end
end
