require 'canvas'

describe Canvas do

  describe "initilization of canvas" do
    before do
      @canvas = Canvas.new(5,5)
    end

    after do
      @canvas = nil
    end

    it "should initilize a canvas with values" do
      expect(@canvas).to be
    end
  end

  describe "size of settings of canvas" do
    it "should return the count of 5 rows if y was set to 5" do
      canvas = Canvas.new(5,5)
      expect(canvas.row_size).to eq(5)
    end

    it "should return the count of 100 rows if y was set to 100" do
      canvas = Canvas.new(5,100)
      expect(canvas.row_size).to eq(100)
    end

    it "should return the count of 5 columns if x was set to 5" do
      canvas = Canvas.new(5,5)
      expect(canvas.column_size).to eq(5)
    end

    it "should return the count of 100 columns if x was set to 100" do
      canvas = Canvas.new(5,5)
      expect(canvas.column_size).to eq(5)
    end
  end

  describe "get color of coordinate" do
    before do
      @canvas = Canvas.new(5, 5)
    end

    after do
      @canvas = nil
    end

    it "should return the color O of a uninialized coordinate" do
      expect(@canvas.color_at(1,1)).to eq('O')
    end
  end

  describe "clearing of canvas" do
    before do
      @canvas = Canvas.new(5, 5)
    end

    after do
      @canvas = nil
    end

    it "should clear a canvas" do
      @canvas.clear!
      @canvas.column_size.times do |x|
        @canvas.column_size.times do |y|
          expect(@canvas.color_at(x,y)).to eq('O')
        end
      end
    end
  end

  describe "to_s" do
    it "should print a 2 x 2 a canvas" do
      @canvas = Canvas.new(2, 2)
      expect(@canvas.to_s).to eq("OO\nOO\n")
    end

    it "should print a 2 x 3 a canvas" do
      @canvas = Canvas.new(2, 3)
      expect(@canvas.to_s).to eq("OO\nOO\nOO\n")
    end
  end

  describe "drawning" do
    before do
      @canvas = Canvas.new(3,3)
    end

    after do
      @canvas = nil
    end

    describe "color_pixel" do
      it "should color the pixel 3 2 to A and return true" do
        @canvas.color_pixel(3,2,'A')
        expect(@canvas.to_s).to eq("OOO\nOOA\nOOO\n")
      end

      it "should color the pixel 1 3 to B and return true" do
        expect(@canvas.color_pixel(1,3,'B')).to eq(true)
        expect(@canvas.to_s).to eq("OOO\nOOO\nBOO\n")
      end

      it "should not color the canvas outside of area, but return false and set" +
        "error" do

        expect(@canvas.color_pixel(4,4,'B')).to eq(false)
        expect(@canvas.to_s).to eq("OOO\nOOO\nOOO\n")
        expect(@canvas.error).to eq("Out of image area.")
      end

      it "should not color the canvas in negative dimenson, but return false " +
        "and set error" do

        expect(@canvas.color_pixel(-4,3,'B')).to eq(false)
        expect(@canvas.to_s).to eq("OOO\nOOO\nOOO\n")
        expect(@canvas.error).to eq("Out of image area.")
      end

      it "should not color the canvas at 0 but set an error and return" +
        "false" do

        expect(@canvas.color_pixel(1,0,'B')).to eq(false)
        expect(@canvas.to_s).to eq("OOO\nOOO\nOOO\n")
        expect(@canvas.error).to eq("Out of image area.")
      end

      it "should not color the canvas at with unknown color" do
        expect(@canvas.color_pixel(1,1,'#333')).to eq(false)
        expect(@canvas.to_s).to eq("OOO\nOOO\nOOO\n")
        expect(@canvas.error).to eq("Unknown color.")
      end
    end

    describe "vertical_line" do
      it "should color the line in 1 column form 2 to 3 in W" do
        expect(@canvas.vertical_line(1,2,3,'W')).to eq(true)
        expect(@canvas.to_s).to eq("OOO\nWOO\nWOO\n")
      end

      it "should color the line in 1 column form 3 to 2 in W" do
        expect(@canvas.vertical_line(1,3,2,'W')).to eq(true)
        expect(@canvas.to_s).to eq("OOO\nWOO\nWOO\n")
      end

      it "should color the line in 1 column form 1 to 3 in W" do
        expect(@canvas.vertical_line(2,1,3,'W')).to eq(true)
        expect(@canvas.to_s).to eq("OWO\nOWO\nOWO\n")
      end

      it "should not color the canvas at with unknown color" do
        expect(@canvas.vertical_line(1,1,3,'#333')).to eq(false)
        expect(@canvas.to_s).to eq("OOO\nOOO\nOOO\n")
        expect(@canvas.error).to eq("Unknown color.")
      end

      it "should not color the canvas at 0 but set an error and return " +
        "false" do

        expect(@canvas.vertical_line(1,0,1,'B')).to eq(false)
        expect(@canvas.to_s).to eq("OOO\nOOO\nOOO\n")
        expect(@canvas.error).to eq("Out of image area.")
      end

      it "should not color the canvas at -1 but set an error and return " +
        "false" do

        expect(@canvas.vertical_line(-1,1,2,'B')).to eq(false)
        expect(@canvas.to_s).to eq("OOO\nOOO\nOOO\n")
        expect(@canvas.error).to eq("Out of image area.")
      end
    end
  end
end
