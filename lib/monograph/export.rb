module Monograph
  class Export
    
    class AlreadyExists < StandardError; end
    
    def initialize(book)
      @book = book
    end
    
    # Return a hash of all HTML files needed for the book. The hash key is 
    # the filename and the value is the full HTML document.
    def html_files
      @html ||= begin
        erb = ERB.new(@book.template)
        hash = {}
        
        # export the chapters
        @book.chapters.inject(hash) do |hash, chapter|
          hash["#{chapter.permalink}.html"] = erb.result(chapter.template_context.get_binding)
          hash
        end
        
        # export other ancillary pages
        ['index.html', 'contents.html'].each do |page|
          context = BookTemplateContext.new(@book, page)
          page_erb = ERB.new(erb.result(context.get_binding))
          hash[page] = page_erb.result(context.get_binding)
        end
        
        hash
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
              content = File.open(path, 'rb', &:read)
              case path.split('.').last
              when 'scss'
                path.gsub!(/.scss\z/, '.css')
                content = Sass::Engine.new(content, :syntax => :scss).render
              end
              hash[path.gsub(/\A.*\/assets\//, '')] = content
            end
            hash
          end
        end
        hash
      end
    end
    
    # Actually run the export to the local file system. This method accepts a path and
    # an optional boolean for forcing the creation.
    def save(path, force = false)
      raise AlreadyExists, "Export path already exists at #{path}" if File.exist?(path) && !force
      FileUtils.rm_rf(path) if File.exist?(path) && force
      FileUtils.mkdir_p(path)
      html_files.each { |filename, content| File.open(File.join(path, filename), 'wb') { |f| f.write(content) }}
      assets.each do |filename, content|
        full_path = File.join(path, filename)
        dir = File.dirname(full_path)
        FileUtils.mkdir_p(dir)
        File.open(full_path, 'w') { |f| f.write(content) }
      end
    end
  end
end
