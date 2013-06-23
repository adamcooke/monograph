module Monograph
  class Book
    
    attr_reader :path
    
    def initialize(path)
      @path = path
    end
    
    def config_path
      File.join(@path, 'config.yml')
    end
    
    def title
      config['title']
    end
    
    def config
      @config ||= YAML.load(File.read(config_path))
    end
    
    def chapters
      @chapters ||= Dir[File.join(@path, '*.md')].map { |path| Monograph::Chapter.new(self, path) }
    end
    
    def builtin_template
      config['template'] || 'default'
    end
    
    def builtin_template_path
      File.join(Monograph.root, 'templates', builtin_template)
    end
    
    def template
      @template ||= begin
        template_path = File.join(@path, 'template.html')
        if File.exist?(template_path)
          File.read(template_path)
        else
          File.read(File.join(builtin_template_path, 'template.html'))
        end
      end
    end
    
    def export
      @export ||= Export.new(self)
    end
    
  end
end
