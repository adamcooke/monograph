class BookTest < Test::Unit::TestCase
  
  def setup
    @book1 = Monograph::Book.new(File.join(FIXTURES_PATH, 'book1'))
    @book2 = Monograph::Book.new(File.join(FIXTURES_PATH, 'book2'))
  end
  
  def test_that_books_can_be_initialized
    assert_equal Monograph::Book, @book1.class
  end
  
  def test_that_books_have_config
    assert @book1.config.is_a?(Hash)
    assert_equal 'Example Book', @book1.config['title']
    assert_equal 'Adam Cooke', @book1.config['author']['name']
    assert_equal 2013, @book1.config['copyright']['year']
  end
  
  def test_that_books_have_chapers
    assert_equal 3, @book1.chapters.length
    assert @book1.chapters.all? { |c| c.is_a?(Monograph::Chapter) }
  end
  
  def test_that_books_have_a_template
    assert_equal File.read(File.join(Monograph.root, 'templates', 'default', 'template.html')), @book1.template
    assert_equal File.read(File.join(@book2.path, 'template.html')), @book2.template
    assert @book2.template =~ /<div class='demo-template'>/
  end
  
end