require 'journey'

describe Journey do

  subject(:journey) {described_class.new}

  describe '#initialize' do
    it 'sets returns default entry station (nil)' do
      expect(journey.entry_station).to be_nil
    end

    it 'sets returns default exit station (nil)' do
      expect(journey.exit_station).to be_nil
    end
  end

end
