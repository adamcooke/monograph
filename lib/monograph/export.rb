module Monograph
  class Export
    
    def initialize(book)
      @book = book
    end
    
    # Return a hash of all HTML files needed for the book. The hash key is 
    # the filename and the value is the full HTML document.
    def html_files
      @html ||= begin
        erb = ERB.new(@book.template)
        @book.chapters.inject({}) do |hash, chapter|
          context = TemplateContext.new(chapter)
          hash["#{chapter.permalink}.html"] = erb.result(context.get_binding)
          hash
        end
      end
    end
    
    # Return a hash of all required assets for the book. This combines all
    # the files from the built-in template with those provided within the
    # book itself. 
    #
    # The copy within the book will always win if there's a filename conflict.
    def assets
      @assets ||= begin
        hash = Hash.new
        search_paths = []
        search_paths << File.join(@book.builtin_template_path, 'assets', '**', '*')
        search_paths << File.join(@book.path, 'assets', '**', '*')
        search_paths.each do |search_path|
          Dir[search_path].inject(hash) do |hash, path|
            if File.file?(path)
              content = File.read(path)
              hash[path.gsub(/\A.*\/assets\//, '')] = content
            end
            hash
          end
        end
        hash
      end
    end
    
  end
end
