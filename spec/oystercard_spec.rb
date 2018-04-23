require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}
  it 'sets a default balance to 0' do
    expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  it 'tops up' do
    card.top_up(5)
    expect(card.balance).to eq 5
  end

  it 'raises error if top up exceeds maximum balance' do
    max_balance = Oystercard::MAX_BALANCE
    expect { card.top_up(91) }.to raise_error "Maximum balance of #{max_balance} exceeded"
  end

  it 'deducts money from a card' do
    card.top_up(10)
    expect(card.deduct(5)).to eq 5
  end

  it 'set default in_journey status to false' do
    expect(card.in_journey?).to be_falsy
  end

  it 'touches in' do
    card.top_up(5)
    card.touch_in
    expect(card).to be_in_journey
  end

  it 'touches out' do
    card.top_up(5)
    card.touch_in
    card.touch_out
    expect(card).to_not be_in_journey
  end

  it 'raises error if balance is below minimum limit' do
    min_balance = Oystercard::MIN_BALANCE
    expect { card.touch_in }.to raise_error "Minimum balance of #{min_balance} required"
  end
end
