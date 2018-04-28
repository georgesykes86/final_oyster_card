

describe Oystercard do
  let(:fare) { 1 }
  let(:max_balance) { Oystercard::MAX_BALANCE}
  let(:default_balance) { Oystercard::DEFAULT_BALANCE }
  let(:min_balance) { Oystercard::MIN_BALANCE }

  subject(:card) {described_class.new(journey_class: journey_class)}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  before { allow(journey_class).to receive(:new).and_return(journey)}
  let(:journey_log) { double :journey_log }


  describe '#top_up' do

    it 'tops up' do
      card.top_up(5)
      expect(card.balance).to eq 5
    end

    it 'raises error if top up exceeds maximum balance' do
      expect { card.top_up(91) }.to raise_error "Maximum balance of #{max_balance} exceeded"
    end

  end

  describe '#initialize' do

    it 'sets a default balance to 0' do
      expect(card.balance).to eq default_balance
    end

  end

  describe '#touch_in' do

    it 'touches in' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it 'raises error if balance is below minimum limit' do
      expect { card.touch_in(entry_station) }.to raise_error "Minimum balance of #{min_balance} required"
    end

    context 'after touch in' do

      before do
        card.top_up(5)
        card.touch_in(entry_station)
      end

      it 'completes journey' do
        expect(journey).to receive(:set_complete)
        card.touch_in(entry_station)
      end

      it 'creates new journey' do
        card.touch_in(entry_station)
        expect(card.journeys.count).to eq 2
      end

    end

  end

  describe '#touch_out' do

    context 'after touch in' do

      before do
        allow(journey).to receive(:complete?).and_return(true)
        allow(journey).to receive(:fare).and_return(fare)
        card.top_up(5)
        card.touch_in(entry_station)
      end

      it 'touches out' do
        card.touch_out(exit_station)
        expect(card).to_not be_in_journey
      end

      it 'deducts money' do
        expect { card.touch_out(exit_station) }.to change { card.balance }.by(-fare)
      end

      it 'completes a journey' do
        card.touch_out(exit_station)
        expect(card.in_journey?).to eq false
      end

    end

    context 'after touch out' do

      before do
        card.top_up(5)
        allow(journey).to receive(:complete?).and_return(false)
        allow(journey).to receive(:fare).and_return(fare)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        allow(journey).to receive(:complete?).and_return(true)
        allow(journey).to receive(:set_complete)

      end

      it 'saves journey' do
        card.touch_out(exit_station)
        expect(card.journeys.count).to eq 2
      end

      it 'deducts money' do
        expect{card.touch_out(exit_station)}.to change{card.balance}.by(-fare)
      end

    end

  end

end
