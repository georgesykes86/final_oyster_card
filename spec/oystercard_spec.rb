require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

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

  # Can be deleted
  describe '#deduct' do

    it 'deducts money from a card' do
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.balance).to eq 9
    end

  end

  describe '#initialize' do

    it 'sets a default balance to 0' do
      expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it 'sets default in_journey status to false' do
      expect(card.in_journey?).to be_falsy
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

    it 'saves entry station' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
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

    it 'removes entry station' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end

  end

  describe '#journeys' do

    it 'saves journey on touch out' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys).to eq [{entry: entry_station, exit: exit_station}]
    end
  end

end
