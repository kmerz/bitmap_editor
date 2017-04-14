require 'colors'

describe Colors do
  describe "Mapping of colors" do
    it "should return 0 if asked for white" do
      expect(Colors.white).to eq('O')
    end

    it "should raise undefined method if unknown color" do
      expect { Colors.funky }.to raise_error(NoMethodError)
    end
  end
end
