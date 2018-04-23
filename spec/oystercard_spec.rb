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

end
