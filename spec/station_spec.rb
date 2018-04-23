require 'station'

describe Station do

subject(:station) {described_class.new('Stratford', 3)}

  describe '#initialize' do
    it 'has name' do
      expect(station.name).to eq 'Stratford'
    end
    it 'has zone' do
      expect(station.zone).to eq 3
    end
  end
end
