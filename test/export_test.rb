class ExportTest < Test::Unit::TestCase
  def setup
    @book = Monograph::Book.new(File.join(FIXTURES_PATH, 'book1'))
    @export = @book.export
  end
  
  def test_html_files_hash_is_present
    assert_equal Hash, @export.html_files.class
    assert_equal ['01-introduction.html','02-dogs.html','03-cats.html', 'index.html', 'contents.html'], @export.html_files.keys
  end
  
  def test_html_files_contains_html
    assert @export.html_files['01-introduction.html'].include?("<title>Introduction - Example Book</title>")
    assert @export.html_files['01-introduction.html'].include?("Introduction</h1>")
    assert @export.html_files['01-introduction.html'].include?("<p>Lorem")
    assert @export.html_files['02-dogs.html'].include?("<title>Dogs - Example Book</title>")
    assert @export.html_files['03-cats.html'].include?("<title>Cats - Example Book</title>")
  end
  
  def test_assets_hash
    assert_equal Hash, @export.assets.class
  end
  
  def test_export_saving
    tmp_path = "/tmp/monograph-book-export"
    FileUtils.rm_rf(tmp_path)
    assert @book.export.save(tmp_path)
    assert File.file?(File.join(tmp_path, '01-introduction.html'))
    assert File.file?(File.join(tmp_path, 'images/penguin.jpg'))
    assert File.file?(File.join(tmp_path, 'stylesheet.css'))
    assert File.file?(File.join(tmp_path, 'index.html'))
  end
  
end
