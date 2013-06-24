class CLITest < Test::Unit::TestCase
  
  def setup
    @book = Monograph::Book.new(File.join(FIXTURES_PATH, 'book1'))
    @cli = Monograph::CLI.new
    @test_path = "/tmp/monograph-new-book"
    FileUtils.rm_rf(@test_path)
  end
  
  def test_init
    new_book = @cli.init(@test_path)
    assert_equal Monograph::Book, new_book.class
    assert File.directory?(@test_path)
    assert File.file?(File.join(@test_path, 'config.yml'))
  end
  
  def test_saving
    @cli.init(@test_path)
    assert_equal Monograph::Book, @cli.build(nil, @test_path).class
    assert File.directory?(File.join(@test_path, 'build'))
    assert File.file?(File.join(@test_path, 'build', 'index.html'))
  end
  
end
