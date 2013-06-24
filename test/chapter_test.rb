class ChapterTest < Test::Unit::TestCase
  
  def setup
    @book = Monograph::Book.new(File.join(FIXTURES_PATH, 'book1'))
    @chapter = @book.chapters[0]
  end
  
  def test_that_chapters_have_access_to_its_book
    assert_equal @book, @chapter.book
  end
  
  def test_that_chapters_have_a_titles
    assert_equal 'Introduction', @chapter.title
    assert_equal ['Introduction', 'Dogs', 'Cats'], @book.chapters.map(&:title)
  end
  
  def test_that_chapters_have_numbers
    assert_equal 1, @chapter.number
    assert_equal [1,2,3], @book.chapters.map(&:number)
  end
  
  def test_that_chapters_have_html_content
    assert @chapter.html =~ /<h1.*>Introduction<\/h1>$/
    assert @chapter.html =~ /<p>Lorem\s/
  end
  
  def test_that_chapters_have_sections
    assert @book.chapters[1].sections.is_a?(Hash)
    assert @book.chapters[1].sections['a-secondary-heading-for-this-page'] = 'A secondary heading for this page'
    assert @book.chapters[1].sections['another-secondary-heading'] = 'Another secondary heading'
    assert @book.chapters[1].sections['a-final-secondary-heading'] = 'A final secondary heading'
  end
  
end