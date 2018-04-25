describe Journey do

  subject(:journey) {described_class.new}
  let(:station) { double :station }
  let(:min_fare) { Journey::MIN_FARE }
  let(:penalty_fare) { Journey::PENALTY_FARE }

  describe '#initialize' do
    context 'when no arguments are given' do
      it 'sets returns default entry station (nil)' do
        expect(journey.entry_station).to be_nil
      end

      it 'shows journey as not being complete by default' do
        expect(journey).not_to be_complete
      end
    end

    context 'when a station argument is given' do
      let(:new_journey) {described_class.new(station)}

      it 'sets the entry station to the station' do
        expect(new_journey.entry_station).to be station
      end
    end
  end

  describe '#set_complete' do

    context 'given an exit station' do
      it 'completes a journey' do
        expect { journey.set_complete(station) }.to change{ journey.complete? }.from(false).to true
      end

      it 'sets the exit station' do
        journey.set_complete(station)
        expect(journey.exit_station).to be station
      end
    end
  end

  describe '#fare' do

    context 'given valid journey' do
      let(:valid_journey) { Journey.new(station) }
      it 'returns minimum fare' do
          valid_journey.set_complete(station)
          expect(valid_journey.fare).to eq min_fare
      end

    end

    context 'given invalid journey not touch out' do
      let(:valid_journey) { Journey.new(station) }
      it 'returns penalty fare' do
        valid_journey.set_complete
        expect(valid_journey.fare).to eq penalty_fare
      end

    end

  end


end
