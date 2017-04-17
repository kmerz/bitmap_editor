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
    end

    describe "Command I" do
      it "should create a image of 5 5" do
        @create_command_file.call("I 5 5\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\n").to_stdout
      end

      it "should create a image of 6 7" do
        @create_command_file.call("I 6 7\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output("OOOOOO\nOOOOOO\nOOOOOO\nOOOOOO\nOOOOOO\nOOOOOO"+
          "\nOOOOOO\n").to_stdout
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

    describe "Command C" do
      it "should not clear a not exsisting canvas" do
        @create_command_file.call('C')
        expect {
          @bitmap_editor.run(@file)
        }.to output("There is no image\n").to_stdout
      end

      it "should clear a exsisting canvas" do
        @create_command_file.call("I 3 3\nL 2 3 B\nC\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/OOO\nOOO\nOOO\n$/).to_stdout
      end

      it "should warn if C gets called with arguments" do
        @create_command_file.call("I 5 5\nC 1 2")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/C has no arguments\n$/).to_stdout
      end
    end

    describe "Command S" do
      it "should not print a not exsisting canvas" do
        @create_command_file.call('S')
        expect {
          @bitmap_editor.run(@file)
        }.to output("There is no image\n").to_stdout
      end

      it "should warn if arguments are given to S" do
        @create_command_file.call("I 2 2\nS am P")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/S has no arguments\n$/).to_stdout
      end

      it "should print the 2 x 2 image" do
        @create_command_file.call("I 2 2\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/OO\nOO\n$/).to_stdout
      end

      it "should print the 2 x 3 image" do
        @create_command_file.call("I 2 3\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/OO\nOO\nOO\n$/).to_stdout
      end
    end

    describe "Command L" do
      it "should not add a pixel to an non exsiting canvas" do
        @create_command_file.call('L 1 1 A')
        expect {
          @bitmap_editor.run(@file)
        }.to output("There is no image\n").to_stdout
      end

      it "should warn if no arguments are given" do
        @create_command_file.call("I 2 3\nL")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/Invalid arguments for L the command takes a coordinate of/).
          to_stdout
      end

      it "should warn if first argument is not an integer" do
        @create_command_file.call("I 2 3\nL A 2 A")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/Invalid arguments for L the command takes a coordinate of/).
          to_stdout
      end

      it "should warn if second argument is not an integer" do
        @create_command_file.call("I 2 3\nL 2 A A")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/Invalid arguments for L the command takes a coordinate of/).
          to_stdout
      end

      it "should warn if third argument is not a color from A to Z" do
        @create_command_file.call("I 2 3\nL 2 3 1")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/Invalid arguments for L the command takes a coordinate of/).
          to_stdout
      end

      it "should add a pixel in color A to coordinate 2 3 if everything is find" do
        @create_command_file.call("I 2 3\nL 2 3 A\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/OO\nOO\nOA\n$/).to_stdout
      end

      it "should not add  a pixel in color A to out of area coordinate" do
        @create_command_file.call("I 2 3\nL 2 4 A\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/Out of image area.\n$/).
          to_stdout
      end
    end

    describe "Command V" do
      it "should add a line of pixel in color W" do
        @create_command_file.call("I 2 3\nV 2 2 3 W\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output("OO\nOW\nOW\n").
          to_stdout
      end

      it "should not add a line to an non exsiting canvas" do
        @create_command_file.call('V 1 1 3 A')
        expect {
          @bitmap_editor.run(@file)
        }.to output("There is no image\n").to_stdout
      end

      it "should warn if no arguments are given" do
        @create_command_file.call("I 2 3\nV\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/Invalid arguments for V the command takes a coordinate of/).
          to_stdout
      end

      it "should warn if invalid arguments are given" do
        @create_command_file.call("I 2 3\nV X X 3 B\nS")
        expect {
          @bitmap_editor.run(@file)
        }.to output(/Invalid arguments for V the command takes a coordinate of/).
          to_stdout
      end
    end
  end
end
