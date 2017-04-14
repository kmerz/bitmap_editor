require 'bitmap_editor'

describe BitmapEditor do

  before do
    @bitmap_editor = BitmapEditor.new
  end

  after do
    @bitmap_editor = nil
  end

  describe "input error handling" do
    it "should warn if file does not exsits" do
      expect {
        @bitmap_editor.run("./DOES_NOT_EXSIT")
      }.to output("please provide correct file\n").to_stdout
    end

    it "should warn if no file was provided" do
      expect {
        @bitmap_editor.run(nil)
      }.to output("please provide correct file\n").to_stdout
    end
  end

  describe "input handling" do
    before do
      @pwd = Dir.pwd
      @tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
      FileUtils.mkdir_p(@tmp_dir)
    end

    after do
      Dir.chdir(@pwd)
      FileUtils.rm_rf(@tmp_dir)
    end

    it "should warn for unrecognized command in file" do
      file = "#{@tmp_dir}/command"
      File.write(file, '💩')
      expect {
        @bitmap_editor.run(file)
      }.to output("unrecognised command :(\n").to_stdout
    end

    it "should warn if command S (show) is called on unitialized bitmap" do
      file = "#{@tmp_dir}/command"
      File.write(file, 'S')
      expect {
        @bitmap_editor.run(file)
      }.to output("There is no image\n").to_stdout
    end
  end
end
