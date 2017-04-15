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
end
