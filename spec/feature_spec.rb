feature 'Oystercard Challenge', :feature do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { Station.new('Oxford Circus') }
  let(:exit_station) { Station.new('Barking') }

  let(:min_fare) { Journey::MIN_FARE }
  let(:penalty_fare) { Journey::PENALTY_FARE }
  let(:max_balance) { Oystercard::MAX_BALANCE}
  let(:default_balance) { Oystercard::DEFAULT_BALANCE }

  before do
    oystercard.top_up(10)
  end

  context 'with valid journey' do

    scenario 'completes a valid journey with touch in and touch out' do
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
      expect{ oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-min_fare)
      expect(oystercard).not_to be_in_journey
      expect(oystercard.journeys.last.entry_station).to be entry_station
      expect(oystercard.journeys.last.exit_station).to be exit_station
    end
  end

  context 'incomplete journey - no touch out' do

    let(:entry_station2) { Station.new('Clapham Common') }
    before do
      oystercard.touch_in(entry_station)
    end

    scenario 'touch in again' do
      expect{ oystercard.touch_in(entry_station2) }.to change{ oystercard.balance }.by(-penalty_fare)
      expect(oystercard).to be_in_journey
      expect(oystercard.journeys.count).to eq 1
      expect(oystercard.journeys.last.entry_station).to be entry_station
    end

  end

  context 'incomplete journey no touch in' do

    let(:exit_station2) { Station.new('Canning Town') }

    scenario 'First use is a touch out' do
      expect{ oystercard.touch_out(exit_station2) }.to change{ oystercard.balance }.by(-penalty_fare)
      expect(oystercard.journeys.count).to eq 1
      expect(oystercard.journeys.last.exit_station).to be exit_station2
      expect(oystercard).not_to be_in_journey
    end

    scenario 'after a touch out' do
      oystercard.touch_in(entry_station)
      expect{ oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-min_fare)
      expect{ oystercard.touch_out(exit_station2) }.to change{ oystercard.balance }.by(-penalty_fare)
      expect(oystercard.journeys.count).to eq 2
      expect(oystercard.journeys.last.exit_station).to be exit_station2
    end

  end
end
