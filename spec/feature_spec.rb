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

  context 'incomplete journey - no touch out' do

    let(:entry_station2) { Station.new('Clapham', 2) }
    before do
      oystercard.touch_in(entry_station)
    end

    scenario 'touch in again' do
      oystercard.touch_in(entry_station2)
      expect(oystercard).to be_in_journey
      expect(oystercard.journeys.count).to eq 2
      expect(oystercard.journeys.last.entry_station).to be entry_station2
      expect(oystercard.journeys[-2]).to be_complete
    end

  end

  context 'incomplete journey no touch in' do

    let(:exit_station2) { Station.new('Notting Hill gate', 1) }

    scenario 'First use is a touch out' do
      oystercard.touch_out(exit_station2)
      expect(oystercard.journeys.count).to eq 1
      expect(oystercard.journeys.last).to be_complete
      expect(oystercard.journeys.last.exit_station).to be exit_station2
    end

    scenario 'after a touch out' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      oystercard.touch_out(exit_station2)
      expect(oystercard.journeys.count).to eq 2
      expect(oystercard.journeys.last).to be_complete
      expect(oystercard.journeys.last.exit_station).to be exit_station2
    end

  end

    subject(:oystercard) { Oystercard.new }
  let(:entry_station)  {Station.new('Oxford Circus', 1)}
  let(:exit_station) { Station.new('London Bridge', 1) }

  it 'logs a standard journey' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
    expect(oystercard.balance).to eq 9
  end

  it 'trys to touch in twice' do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
    expect(oystercard.journey_log.journeys.count).to eq 1
    expect(oystercard.balance).to eq 4
  end

  it 'tries to touch out twice' do
    oystercard.top_up(10)
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
    expect(oystercard.journey_log.journeys.count).to eq 1
    expect(oystercard.balance).to eq 4
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
    expect(oystercard.journey_log.journeys.count).to eq 2
    expect(oystercard.balance).to eq -2
  end

end
