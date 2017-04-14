require 'canvas'

describe Canvas do

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
