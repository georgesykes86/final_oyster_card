

describe Oystercard do

  subject(:card) {described_class.new}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { instance_double :journey, complete?: false }

  describe '#top_up' do

    it 'tops up' do
      card.top_up(5)
      expect(card.balance).to eq 5
    end

    it 'raises error if top up exceeds maximum balance' do
      max_balance = Oystercard::MAX_BALANCE
      expect { card.top_up(91) }.to raise_error "Maximum balance of #{max_balance} exceeded"
    end

  end

  describe '#initialize' do

    it 'sets a default balance to 0' do
      expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it 'sets default in_journey status to false' do
      expect(card.in_journey?).to be false
    end

    it 'sets default journey history to empty' do
      expect(card.journeys).to eq []
    end

  end

  describe '#touch_in' do

    it 'touches in' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it 'raises error if balance is below minimum limit' do
      min_balance = Oystercard::MIN_BALANCE
      expect { card.touch_in(entry_station) }.to raise_error "Minimum balance of #{min_balance} required"
    end

  end

  describe '#touch_out' do

    it 'touches out' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).to_not be_in_journey
    end

    it 'deducts money' do
      min_fare = Oystercard::MIN_FARE
      card.top_up(5)
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station) }.to change { card.balance }.by(-min_fare)
    end

    it 'completes a journey' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.in_journey?).to eq false
    end

  end

  describe '#journeys' do

    it 'saves journey on touch out' do
      pending("refactoring")
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys).to eq [{entry: entry_station, exit: exit_station}]
    end
  end

end
