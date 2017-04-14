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
      @file = "#{@tmp_dir}/command"
      @create_command_file = lambda{|cmd_line| File.write(@file, cmd_line) }
    end

    after do
      Dir.chdir(@pwd)
      FileUtils.rm_rf(@tmp_dir)
      @create_command_file = nil
      @file
    end

    describe "Error handling" do
      it "should warn for unrecognized command in file" do
        @create_command_file.call('💩')
        expect {
          @bitmap_editor.run(@file)
        }.to output("unrecognised command :(\n").to_stdout
      end

      it "should warn if command S (show) is called on unitialized bitmap" do
        @create_command_file.call('S')
        expect {
          @bitmap_editor.run(@file)
        }.to output("There is no image\n").to_stdout
      end
    end

    describe "Command I" do
      it "should create a image of 5 5" do
        @create_command_file.call('I 5 5')
        expect {
          @bitmap_editor.run(@file)
        }.to output("Create a new image of 5 x 5\n").to_stdout
      end

      it "should create a image of 100 125" do
        @create_command_file.call('I 100 125')
        expect {
          @bitmap_editor.run(@file)
        }.to output("Create a new image of 100 x 125\n").to_stdout
      end

      it "should warn if the arguments are not integers" do
        @create_command_file.call('I am 💩')
        expect {
          @bitmap_editor.run(@file)
        }.to output("Command I got non integer arguments\n").to_stdout
      end

      it "should warn if rows the arguments are to big" do
        @create_command_file.call('I 5 251')
        expect {
          @bitmap_editor.run(@file)
        }.to output("Rows value must be between 1 and 250\n").to_stdout
      end

      it "should warn if rows the arguments are to small" do
        @create_command_file.call('I 5 0')
        expect {
          @bitmap_editor.run(@file)
        }.to output("Rows value must be between 1 and 250\n").to_stdout
      end

      it "should warn if columns the arguments are to big" do
        @create_command_file.call('I 251 5')
        expect {
          @bitmap_editor.run(@file)
        }.to output("Columns value must be between 1 and 250\n").to_stdout
      end

      it "should warn if columns the arguments are to small" do
        @create_command_file.call('I 0 5')
        expect {
          @bitmap_editor.run(@file)
        }.to output("Columns value must be between 1 and 250\n").to_stdout
      end
    end
  end
end
