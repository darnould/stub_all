require_relative "stub_all"

require_relative "sut"

Kernel.stub_all

describe SUT do
  context "with require()'d classes stubbed" do
    let(:faraday) { instance_double('Faraday') }
    before :each do
      allow(Faraday).to receive(:new).and_return faraday
    end

    it "works" do
      expect(SUT.new.dependency).to eq faraday
    end
  end

  context "with a require()'d class not stubbed" do
    it "forces dev to stub out the dependency, with an exception" do
      expect do
        SUT.new
      end.to raise_exception
    end
  end
end
