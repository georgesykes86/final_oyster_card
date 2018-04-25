feature 'Oystercard Challenge', :feature do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { Station.new('Oxford Circus', 1) }
  let(:exit_station) { Station.new('Oxford Circus', 1) }

  let(:min_fare) { Journey::MIN_FARE }
  let(:max_balance) { Oystercard::MAX_BALANCE}
  let(:default_balance) { Oystercard::DEFAULT_BALANCE }

  before do
    oystercard.top_up(10)
  end

  context 'with valid journey' do
    before do
      oystercard.touch_in(entry_station)
    end

    scenario 'creating a journey on touch in' do
      expect(oystercard).to be_in_journey
    end

    scenario 'completes a valid journey on touch out' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
      expect(oystercard.journeys.last.entry_station).to be entry_station
      expect(oystercard.journeys.last.exit_station).to be exit_station
    end

    scenario 'deducts fare given valid journey' do
      expect{ oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-min_fare)
    end

  end
end
