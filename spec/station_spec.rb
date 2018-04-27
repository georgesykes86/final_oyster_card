fdescribe Station do

subject(:station) {described_class.new('Oxford Circus')}
let(:station_checker) { double :station_checker, get_zone: 1 }

  describe '#initialize' do
    it 'has name' do
      expect(station.name).to eq 'Oxford Circus'
    end
    it 'has zone' do
      expect(station.zone).to eq 1
    end
  end
end
