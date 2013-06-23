class ExportTest < Test::Unit::TestCase
  def setup
    @book = Monograph::Book.new(File.join(FIXTURES_PATH, 'book1'))
    @export = @book.export
  end
  
  def test_html_files_hash_is_present
    assert_equal Hash, @export.html_files.class
    assert_equal ['01-introduction','02-dogs','03-cats'], @export.html_files.keys
  end
  
  def test_html_files_contains_html
    assert @export.html_files['01-introduction'].include?("<title>Introduction - Example Book</title>")
    assert @export.html_files['01-introduction'].include?("Introduction</h1>")
    assert @export.html_files['01-introduction'].include?("<p>Lorem")
    assert @export.html_files['02-dogs'].include?("<title>Dogs - Example Book</title>")
    assert @export.html_files['03-cats'].include?("<title>Cats - Example Book</title>")
  end
  
  def test_assets_hash
    assert_equal Hash, @export.assets.class
  end
  
end
