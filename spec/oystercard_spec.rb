require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}
  it 'sets a default card balance to 0' do
    expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
  end

end
