require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}

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
      card.touch_in
      card.touch_out
      expect(card.balance).to eq 9
    end

  end

  describe '#initialize' do

    it 'sets a default balance to 0' do
      expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it 'set default in_journey status to false' do
      expect(card.in_journey?).to be_falsy
    end

  end

  describe '#touch_in' do

    it 'touches in' do
      card.top_up(5)
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'raises error if balance is below minimum limit' do
      min_balance = Oystercard::MIN_BALANCE
      expect { card.touch_in }.to raise_error "Minimum balance of #{min_balance} required"
    end

  end

  describe '#touch_out' do

    it 'touches out' do
      card.top_up(5)
      card.touch_in
      card.touch_out
      expect(card).to_not be_in_journey
    end

    it 'deducts money' do
      min_fare = Oystercard::MIN_FARE
      card.top_up(5)
      card.touch_in
      expect { card.touch_out }.to change { card.balance }.by(-min_fare)
    end

  end

end
