require 'colors'

describe Colors do
  describe "Mapping of colors" do
    it "should return 0 if asked for white" do
      expect(Colors.white).to eq('O')
    end

    it "should raise undefined method if unknown color" do
      expect { Colors.funky }.to raise_error(NoMethodError)
    end

    it "should ensure that a known color is valid" do
      expect(Colors.validate(Colors.white)).to eq(true)
    end

    it "should ensure that a unknown color is invalid" do
      expect(Colors.validate('#333')).to eq(false)
    end
  end
end
