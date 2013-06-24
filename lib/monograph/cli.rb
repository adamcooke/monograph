module Monograph
  class CLI
    
    class Error < StandardError; end
    
    # Initialize a new book in the given path
    def init(path = nil)
      raise Error, "You must specify a path to create your new book in" if path.nil?
      raise Error, "File already exists at #{path}" if File.exist?(path)
      FileUtils.mkdir_p(path)
      FileUtils.cp_r(File.join(Monograph.root, 'test', 'fixtures', 'book1', '.'), path)
      puts "Initialized new monograph book at #{path}"
      Book.new(path)
    end
    
    # Export a book, assuming we're in the root of it
    def build(destination = nil, source = nil)
      source = Dir.pwd if source.nil?
      destination = File.join(source, 'build') if destination.nil?
      raise Error, "You are not currently within a Monograph root" unless File.exist?(File.join(source, 'config.yml'))
      FileUtils.rm_rf(destination)
      book = Book.new(source)
      book.export.save(destination)
      puts
      puts " Saved build to #{destination}."
      puts " Open your cover page at file://#{File.expand_path(destination)}/index.html"
      puts
      book
    end
    
  end
end
