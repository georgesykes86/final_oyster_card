describe Journeylog do
  let(:station1) { double 'Station A' }
  let(:station2) { double 'Station B' }
  let(:journey_class) { double :journey_class, new: journey}
  let(:journey) { double :journey, entry_station: 'Station A',  exit_station: 'Station B' }
  let(:subject) { Journeylog.new(journey_class)}

  before do
    allow(journey).to receive(:add_exit_station).with(any_args)
  end

  context 'on set-up' do
    it 'has an empty #journey_history array' do
      expect(subject.journeys).to be_empty
    end

    it 'has a fare of zero' do
      expect(subject.fare).to eq 0
    end

    it 'defaults to not being in journey' do
      expect(subject).not_to be_in_journey
    end


  end
  describe '#start' do
    it 'creates a new journey' do
      subject.start(station1)
      expect(subject).to be_in_journey
    end

    context 'when in_journey'
    before { allow(journey).to receive(:fare).and_return(6) }

    before do
      subject.start(station1)
      subject.start(station2)
    end

      it 'sets the current journey' do
        expect(subject).to be_in_journey
      end

      it 'finishes the previous journey' do
        expect(subject.journeys.count).to eq 1
        expect(subject.journeys.last.entry_station).to eq 'Station A'
      end

      it 'sets the fare to the penalty fare' do
        expect(subject.fare).to eq 6
      end
  end

  describe '#finish' do
    before do
      allow(journey).to receive(:fare).and_return(1)
    end

    context 'when in journey' do
      before { subject.start(station1) }

      it 'sets the exit station' do
        expect(journey).to receive(:add_exit_station).with(station2)
        subject.finish(station2)
      end

      it 'saves the journey' do
        subject.finish(station2)
        expect(subject.journeys.count).to be 1
      end

      it 'sets the fare' do
        expect(journey).to receive(:fare)
        subject.finish(station2)
      end

      it 'resets current journey' do
        subject.finish(station2)
        expect(subject).not_to be_in_journey
      end
    end

    context 'when not in journey' do
      it 'creates a journey' do
        expect(journey_class).to receive(:new).with(nil)
        subject.finish(station2)
      end

    end

  end

end
