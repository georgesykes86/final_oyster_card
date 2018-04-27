fdescribe Journey do

  subject(:journey) {described_class.new(nil)}
  let(:valid_journey) { Journey.new(station) }
  let(:station) { double :station }
  let(:min_fare) { Journey::MIN_FARE }
  let(:penalty_fare) { Journey::PENALTY_FARE }

  describe '#initialize' do
    context 'when no arguments are given' do
      it 'sets returns default entry station (nil)' do
        expect(journey.entry_station).to be_nil
      end
    end

    context 'when a station argument is given' do

      it 'sets the entry station to the station' do
        expect(valid_journey.entry_station).to be station
      end
    end
  end

  describe '#add_exit_station' do

    context 'given an exit station' do

      it 'sets the exit station' do
        journey.add_exit_station(station)
        expect(journey.exit_station).to be station
      end
    end
  end

  describe '#fare' do

    context 'given valid journey' do
      it 'returns minimum fare' do
        valid_journey.add_exit_station(station)
        expect(valid_journey.set_fare).to eq min_fare
      end

    end

    context 'given invalid journey not touch out' do
      it 'returns penalty fare' do
        valid_journey.add_exit_station(nil)
        expect(valid_journey.set_fare).to eq penalty_fare
      end

    end

    context 'given invalid journey no touch in' do
      it 'returns a penalty fare' do
        journey.add_exit_station(station)
        expect(journey.set_fare).to eq penalty_fare
      end

    end

  end


end
