class TemplateContextTest < Test::Unit::TestCase
  
  def setup
    @book = Monograph::Book.new(File.join(FIXTURES_PATH, 'book1'))
    @chapter = @book.chapters[1]
    @context = @chapter.template_context
  end
  
  def test_chapter_title
    assert_equal 'Dogs', @context.chapter_title
  end
  
  def test_book_title
    assert_equal 'Example Book', @context.book_title
  end
  
  def test_next_chapter
    assert_equal @book.chapters[2], @context.next_chapter
  end
  
  def test_previous_chapter
    assert_equal @book.chapters[0], @context.previous_chapter
  end
  
  def test_next_chapter_on_last_chapter
    assert_equal nil, @book.chapters[2].template_context.next_chapter
  end

  def test_previous_chapter_on_first_chapter
    assert_equal nil, @book.chapters[0].template_context.previous_chapter
  end
  
  def test_chapters
    assert_equal @book.chapters, @context.chapters
  end
  
  def test_content
    assert_equal @chapter.html, @context.content
  end

end