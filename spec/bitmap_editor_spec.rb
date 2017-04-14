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

  describe "Input handling" do
    before do
      @pwd = Dir.pwd
      @tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
      FileUtils.mkdir_p(@tmp_dir)
    end

    after do
      Dir.chdir(@pwd)
      FileUtils.rm_rf(@tmp_dir)
    end

    describe "Error handling" do
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

    describe "Command I" do
      it "should create a image of 5 5" do
        file = "#{@tmp_dir}/command"
        File.write(file, 'I 5 5')
        expect {
          @bitmap_editor.run(file)
        }.to output("Create a new image of 5 x 5\n").to_stdout
      end

      it "should create a image of 100 125" do
        file = "#{@tmp_dir}/command"
        File.write(file, 'I 100 125')
        expect {
          @bitmap_editor.run(file)
        }.to output("Create a new image of 100 x 125\n").to_stdout
      end

      it "should warn if the arguments are not integers" do
        file = "#{@tmp_dir}/command"
        File.write(file, 'I am 💩')
        expect {
          @bitmap_editor.run(file)
        }.to output("Command I got non integer arguments\n").to_stdout
      end

      it "should warn if rows the arguments are to big" do
        file = "#{@tmp_dir}/command"
        File.write(file, 'I 5 251')
        expect {
          @bitmap_editor.run(file)
        }.to output("Rows value must be between 1 and 250\n").to_stdout
      end

      it "should warn if rows the arguments are to small" do
        file = "#{@tmp_dir}/command"
        File.write(file, 'I 5 0')
        expect {
          @bitmap_editor.run(file)
        }.to output("Rows value must be between 1 and 250\n").to_stdout
      end

      it "should warn if columns the arguments are to big" do
        file = "#{@tmp_dir}/command"
        File.write(file, 'I 251 5')
        expect {
          @bitmap_editor.run(file)
        }.to output("Columns value must be between 1 and 250\n").to_stdout
      end

      it "should warn if columns the arguments are to small" do
        file = "#{@tmp_dir}/command"
        File.write(file, 'I 0 5')
        expect {
          @bitmap_editor.run(file)
        }.to output("Columns value must be between 1 and 250\n").to_stdout
      end
    end
  end
end
